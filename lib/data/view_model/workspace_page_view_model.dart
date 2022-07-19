// 🐦 Flutter imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// 🌎 Project imports:
import '../utility/logger/logger.dart';

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

  Future<void> createNewWorkSpace() async {
    if (newWorkspaceName.isNotEmpty) {
      try {
        await Future.delayed(const Duration(seconds: 1));
        // await FirebaseFirestore.instance.collection('workspaces').add({
        //   'name': newWorkspaceName,
        //   'imageUrl':
        //       'https://user-images.githubusercontent.com/67848399/177277341-f0a9d6cc-d844-46d9-baa0-42b7c6b317e1.jpeg',
        //   'members': [],
        //   'owners': ['XXXXXXXXXX'], // ログイン中のユーザーを格納
        //   'createUser': 'XXXXXXXXXX', // 作成者のUID
        //   'createdAt': DateTime.now(),
        //   'updatedAt': DateTime.now(),
        // });
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

final workspaceFutureProvider = FutureProvider.autoDispose(
  (ref) async {
    final joinedWorkspaces = await fetchJoinedWorkSpaceList();
    return fetchWorkspaceList(joinedWorkspaces);
  },
);
