// π¦ Flutter imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// π¦ Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/data/model/workspace_model.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// π Project imports:
import '../utility/logger/logger.dart';

final workspacePageViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return WorkspacePageViewModel();
  },
);

class WorkspacePageViewModel extends ChangeNotifier {
  WorkspacePageViewModel();

  /// ηΆζγζγ€ε€ζ°
  String newWorkspaceName = '';
  bool isConnecting = true;
  String selectedWorkspaceId = '';

  /// stateγζ΄ζ°γγγ‘γ½γγ
  // γ―γΌγ―γΉγγΌγΉεγζ΄ζ°
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
        WorkspaceModel workspaceModel = WorkspaceModel.initialData();
        workspaceModel.name = newWorkspaceName;

        await FirebaseFirestore.instance
            .collection('workspaces')
            .doc(workspaceModel.workspaceId)
            .set(workspaceModel.toMap());
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
      // ηΆζγε€γγ£γγιη₯γγ
      if (beforeState != isConnecting) {
        notifyListeners();
      }
    } on Exception catch (e) {
      logger.wtf(e);
    }
  }
}

/// FutureProviderη¨

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
