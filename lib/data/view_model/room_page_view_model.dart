// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/data/model/genre_model.dart';
import 'package:qtank_mobile/data/model/room_model.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// 🌎 Project imports:

final roomPageViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return RoomPageViewModel();
  },
);

class RoomPageViewModel extends ChangeNotifier {
  RoomPageViewModel();

  /// 状態を持つ変数
  String roomName = '';
  bool isConnecting = true;

  /// stateを更新するメソッド
  // ワークスペース名を更新
  void updateRoomName(String name) {
    roomName = name;
  }

  /// genreに新しいroomを追加するメソッド
  Future<void> addNewRoom(GenreModel genreModel) async {
    RoomModel roomModel = RoomModel.initialData();
    roomModel.name = roomName;
    roomModel.genreId = genreModel.genreId;
    roomModel.workspaceId = genreModel.workspaceId;
    if (roomName.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('workspaces')
            .doc(genreModel.workspaceId)
            .collection('rooms')
            .doc(roomModel.roomId)
            .set(roomModel.toMap());
      } on FirebaseException catch (e) {
        logger.w(e);
      }
    }
  }
}
