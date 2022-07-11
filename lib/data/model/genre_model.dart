// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class GenreModel {
  GenreModel({
    required this.workspaceId,
    required this.genreId,
    required this.genreName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GenreModel.fromMap(Map<String, dynamic> data) => GenreModel(
        workspaceId: data['workspaceId'],
        genreId: data['genreId'],
        genreName: data['genreName'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

  factory GenreModel.initialData() => GenreModel(
        workspaceId: '',
        genreId: '',
        genreName: '',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  String workspaceId;
  String genreId;
  String genreName;
  Timestamp createdAt;
  Timestamp updatedAt;

  Map<String, dynamic> toMap() => {
        'workspaceId': workspaceId,
        'genreId': genreId,
        'genreName': genreName,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
