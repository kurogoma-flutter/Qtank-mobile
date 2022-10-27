// 🐦 Flutter imports:

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qtank_mobile/data/model/workspace_model.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// 🌎 Project imports:
import '../model/content_model.dart';
import '../model/genre_model.dart';
import '../model/room_model.dart';

final workspacePageViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return WorkspacePageViewModel();
  },
);

class WorkspacePageViewModel extends ChangeNotifier {
  WorkspacePageViewModel();

  /// 状態を持つ変数
  String newWorkspaceName = '';
  bool isConnecting = true;
  String selectedWorkspaceId = '';
  XFile? selectedImageFile;

  /// 各メソッド用の変数
  final ImagePicker _picker = ImagePicker();

  /// stateを更新するメソッド
  // ワークスペース名を更新
  void updateWorkspaceName(String name) {
    newWorkspaceName = name;
    notifyListeners();
  }

  void setSelectedWorkspace(String workspaceId) {
    selectedWorkspaceId = workspaceId;
    logger.i(selectedWorkspaceId);
    notifyListeners();
  }

  Future<void> createNewWorkSpace(BuildContext context) async {
    if (newWorkspaceName.isNotEmpty) {
      try {
        // 1. ワークスペースの値をセット
        WorkspaceModel workspaceModel = WorkspaceModel.initialData();
        workspaceModel.name = newWorkspaceName;
        // 2. ワークスペースをFirestoreに保存
        await FirebaseFirestore.instance
            .collection('workspaces')
            .doc(workspaceModel.workspaceId)
            .set(workspaceModel.toMap());
        // 3. ワークスペース一覧に追加
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'joinedWorkspaces':
              FieldValue.arrayUnion([workspaceModel.workspaceId])
        });
        // 4. ワークスペース画面に移動
        // ignore: use_build_context_synchronously
        context.go(
            '/workspace/${workspaceModel.workspaceId}/${workspaceModel.name}');
      } on FirebaseException catch (e) {
        logger.w(e);
      }
    }
  }

  Future<void> checkConnectionState() async {
    try {
      bool beforeState = isConnecting;
      var connectivityResult = await Connectivity().checkConnectivity();
      logger.i(connectivityResult);
      if (connectivityResult == ConnectivityResult.none) {
        isConnecting = false;
      } else {
        isConnecting = true;
      }
      // 状態が変わったら通知する
      if (beforeState != isConnecting) {
        notifyListeners();
      }
    } on Exception catch (e) {
      logger.wtf(e);
    }
  }

  /// imagePickerで画像を取得する
  Future<void> pickUpImage() async {
    selectedImageFile = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }
}

/// FutureProvider用

Future<List<dynamic>> fetchJoinedWorkSpaceList() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return snapshot.get('joinedWorkspaces');
}

Future<QuerySnapshot<Map<String, dynamic>>> fetchWorkspaceList(
    List<dynamic> workspaceList) {
  return FirebaseFirestore.instance
      .collection('workspaces')
      .where('workspaceId', whereIn: workspaceList)
      .get();
}

final workspaceListFutureProvider = FutureProvider.autoDispose(
  (ref) async {
    final joinedWorkspaces = await fetchJoinedWorkSpaceList();
    return fetchWorkspaceList(joinedWorkspaces);
  },
);

final workspaceFutureProvider = FutureProvider.autoDispose
    .family<WorkspaceModel, String>((ref, workspaceId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('workspaces')
      .doc(workspaceId)
      .get();

  return WorkspaceModel.fromMap(snapshot.data()!);
});

final workspaceGenreFutureProvider = FutureProvider.autoDispose
    .family<List<GenreModel>, String>((ref, workspaceId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('workspaces')
      .doc(workspaceId)
      .collection('genres')
      .get();

  return snapshot.docs.map((data) {
    return GenreModel.fromMap(data.data());
  }).toList();
});

final workspaceRoomFutureProvider = FutureProvider.autoDispose
    .family<List<RoomModel>, List<String>>((ref, info) async {
  final workspaceId = info[0];
  final genreId = info[1];
  final snapshot = await FirebaseFirestore.instance
      .collection('workspaces')
      .doc(workspaceId)
      .collection('rooms')
      .where('genreId', isEqualTo: genreId)
      .get();

  return snapshot.docs.map((data) {
    return RoomModel.fromMap(data.data());
  }).toList();
});

final workspaceContentFutureProvider = FutureProvider.autoDispose
    .family<List<ContentModel>, List<String>>((ref, info) async {
  final workspaceId = info[0];
  final roomId = info[1];
  final snapshot = await FirebaseFirestore.instance
      .collection('workspaces')
      .doc(workspaceId)
      .collection('contents')
      .where('roomId', isEqualTo: roomId)
      .get();

  return snapshot.docs.map((data) {
    return ContentModel.fromMap(data.data());
  }).toList();
});

final fetchWorkSpaceImageFromId =
    FutureProvider.autoDispose.family<String, String>((ref, workspaceId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('workspaces')
      .doc(workspaceId)
      .get();
  return snapshot.get('imageUrl');
});
