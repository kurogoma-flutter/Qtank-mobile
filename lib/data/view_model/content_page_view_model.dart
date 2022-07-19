// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/data/model/content_model.dart';
import 'package:qtank_mobile/data/model/room_model.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// 🌎 Project imports:
import '../utility/logger/logger.dart';

final contentPageViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return ContentPageViewModel();
  },
);

class ContentPageViewModel extends ChangeNotifier {
  ContentPageViewModel();

  /// 状態を持つ変数
  String contentText = '';
  bool isConnecting = true;

  /// stateを更新するメソッド
  // ワークスペース名を更新
  void updateContentText(String text) {
    contentText = text;
  }

  /// roomに新しいコンテンツを追加するメソッド
  Future<void> addNewContent(RoomModel roomModel) async {
    ContentModel contentModel = ContentModel.initialData();
    contentModel.contentText = contentText;
    contentModel.roomId = roomModel.roomId;
    contentModel.genreId = roomModel.genreId;
    contentModel.workspaceId = roomModel.workspaceId;

    if (contentText.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('workspaces')
            .doc(roomModel.workspaceId)
            .collection('contents')
            .doc(contentModel.contentId)
            .set(contentModel.toMap());
      } on FirebaseException catch (e) {
        logger.w(e);
      }
    }
  }
}
