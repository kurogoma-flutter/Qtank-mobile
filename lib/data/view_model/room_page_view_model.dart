// π¦ Flutter imports:
import 'package:flutter/material.dart';

// π¦ Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/data/model/genre_model.dart';
import 'package:qtank_mobile/data/model/room_model.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// π Project imports:
import '../utility/logger/logger.dart';

final roomPageViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return RoomPageViewModel();
  },
);

class RoomPageViewModel extends ChangeNotifier {
  RoomPageViewModel();

  /// ηΆζγζγ€ε€ζ°
  String roomName = '';
  bool isConnecting = true;

  /// stateγζ΄ζ°γγγ‘γ½γγ
  // γ―γΌγ―γΉγγΌγΉεγζ΄ζ°
  void updateRoomName(String name) {
    roomName = name;
  }

  /// genreγ«ζ°γγroomγθΏ½ε γγγ‘γ½γγ
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
