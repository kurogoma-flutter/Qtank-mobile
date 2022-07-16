// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkspaceModel {
  WorkspaceModel({
    required this.name,
    required this.workspaceId,
    required this.imageUrl,
    required this.companyUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkspaceModel.fromMap(Map<String, dynamic> data) => WorkspaceModel(
        name: data['name'],
        workspaceId: data['workspaceId'],
        imageUrl: data['imageUrl'],
        companyUrl: data['companyUrl'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

  factory WorkspaceModel.initialData() => WorkspaceModel(
        name: '',
        workspaceId: '',
        imageUrl: '',
        companyUrl: '',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  String name;
  String workspaceId;
  String imageUrl;
  String companyUrl;
  Timestamp createdAt;
  Timestamp updatedAt;

  Map<String, dynamic> toMap() => {
        'name': name,
        'workspaceId': workspaceId,
        'imageUrl': imageUrl,
        'companyUrl': companyUrl,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
