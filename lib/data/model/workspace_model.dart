// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkspaceModel {
  WorkspaceModel({
    required this.name,
    required this.workspaceId,
    required this.companyUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkspaceModel.fromMap(Map<String, dynamic> data) => WorkspaceModel(
        name: data['name'],
        workspaceId: data['workspaceId'],
        companyUrl: data['companyUrl'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

  factory WorkspaceModel.initialData() => WorkspaceModel(
        name: '',
        workspaceId: '',
        companyUrl: '',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  String name;
  String workspaceId;
  String companyUrl;
  Timestamp createdAt;
  Timestamp updatedAt;

  Map<String, dynamic> toMap() => {
        'name': name,
        'workspaceId': workspaceId,
        'companyUrl': companyUrl,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
