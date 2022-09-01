// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/data/model/genre_model.dart';
import 'package:qtank_mobile/data/model/workspace_model.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';

// 🌎 Project imports:

final genrePageViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return GenrePageViewModel();
  },
);

class GenrePageViewModel extends ChangeNotifier {
  GenrePageViewModel();

  /// 状態を持つ変数
  String genreName = '';
  bool isConnecting = true;

  /// stateを更新するメソッド
  // ワークスペース名を更新
  void updateGenreName(String name) {
    genreName = name;
  }

  /// genreに新しいroomを追加するメソッド
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
