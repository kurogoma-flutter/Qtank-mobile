// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class GenreModel {
  GenreModel({
    required this.workspaceId,
    required this.genreId,
    required this.genreName,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GenreModel.fromMap(Map<String, dynamic> data) => GenreModel(
        workspaceId: data['workspaceId'],
        genreId: data['genreId'],
        genreName: data['genreName'],
        icon: data['icon'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

  factory GenreModel.initialData() => GenreModel(
        workspaceId: '',
        genreId: const Uuid().v4(),
        genreName: '',
        icon: '💡',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  String workspaceId;
  String genreId;
  String genreName;
  String icon;
  Timestamp createdAt;
  Timestamp updatedAt;

  Map<String, dynamic> toMap() => {
        'workspaceId': workspaceId,
        'genreId': genreId,
        'genreName': genreName,
        'icon': icon,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
