// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// 🌎 Project imports:
import '../utility/logger/logger.dart';

final workspacePageViewModelProvider =
    ChangeNotifierProvider<WorkspacePageViewModel>(
  (ref) {
    return WorkspacePageViewModel();
  },
);

class WorkspacePageViewModel extends ChangeNotifier {
  WorkspacePageViewModel();

  /// 状態を持つ変数
  String newWorkspaceName = '';

  /// stateを更新するメソッド
  // ワークスペース名を更新
  void updateWorkspaceName(String name) {
    newWorkspaceName = name;
    notifyListeners();
  }

  Future<void> createNewWorkSpace() async {
    if (newWorkspaceName.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('workspaces').add({
          'name': newWorkspaceName,
          'imageUrl':
              'https://user-images.githubusercontent.com/67848399/177277341-f0a9d6cc-d844-46d9-baa0-42b7c6b317e1.jpeg',
          'members': [],
          'owners': ['XXXXXXXXXX'], // ログイン中のユーザーを格納
          'createUser': 'XXXXXXXXXX', // 作成者のUID
          'createdAt': DateTime.now(),
          'updatedAt': DateTime.now(),
        });
      } on FirebaseException catch (e) {
        logger.w(e);
      }
    }
  }
}