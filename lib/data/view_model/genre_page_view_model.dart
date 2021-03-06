// π¦ Flutter imports:
import 'package:flutter/material.dart';

// π¦ Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/data/model/genre_model.dart';
import 'package:qtank_mobile/data/model/workspace_model.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// π Project imports:
import '../utility/logger/logger.dart';

final genrePageViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return GenrePageViewModel();
  },
);

class GenrePageViewModel extends ChangeNotifier {
  GenrePageViewModel();

  /// ηΆζγζγ€ε€ζ°
  String genreName = '';
  bool isConnecting = true;

  /// stateγζ΄ζ°γγγ‘γ½γγ
  // γ―γΌγ―γΉγγΌγΉεγζ΄ζ°
  void updateGenreName(String name) {
    genreName = name;
  }

  /// genreγ«ζ°γγroomγθΏ½ε γγγ‘γ½γγ
  Future<void> addNewGenre(WorkspaceModel workspaceModel) async {
    GenreModel genreModel = GenreModel.initialData();
    genreModel.genreName = genreName;
    genreModel.workspaceId = workspaceModel.workspaceId;
    if (genreName.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('workspaces')
            .doc(workspaceModel.workspaceId)
            .collection('genres')
            .doc(genreModel.genreId)
            .set(genreModel.toMap());
      } on FirebaseException catch (e) {
        logger.w(e);
      }
    }
  }
}
