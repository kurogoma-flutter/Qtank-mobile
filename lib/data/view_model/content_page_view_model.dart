// π¦ Flutter imports:
import 'package:flutter/material.dart';

// π¦ Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/data/model/content_model.dart';
import 'package:qtank_mobile/data/model/room_model.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// π Project imports:
import '../utility/logger/logger.dart';

final contentPageViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return ContentPageViewModel();
  },
);

class ContentPageViewModel extends ChangeNotifier {
  ContentPageViewModel();

  /// ηΆζγζγ€ε€ζ°
  String contentText = '';
  bool isConnecting = true;

  /// stateγζ΄ζ°γγγ‘γ½γγ
  // γ―γΌγ―γΉγγΌγΉεγζ΄ζ°
  void updateContentText(String text) {
    contentText = text;
  }

  /// roomγ«ζ°γγγ³γ³γγ³γγθΏ½ε γγγ‘γ½γγ
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
