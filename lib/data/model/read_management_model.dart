// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadManagementModel {
  ReadManagementModel({
    required this.workspaceId,
    required this.roomId,
    required this.contentId,
    required this.createUserId,
    required this.readUsers,
    required this.createdAt,
  });

  factory ReadManagementModel.fromMap(Map<String, dynamic> data) =>
      ReadManagementModel(
        workspaceId: data['workspaceId'],
        roomId: data['roomId'],
        contentId: data['contentId'],
        createUserId: data['createUserId'],
        readUsers: List<String>.from(data['readUsers']),
        createdAt: data['createdAt'],
      );

  factory ReadManagementModel.initialData() => ReadManagementModel(
        workspaceId: '',
        roomId: '',
        contentId: '',
        createUserId: '',
        readUsers: [],
        createdAt: Timestamp.now(),
      );

  String workspaceId;
  String roomId;
  String contentId;
  String createUserId;
  List<String> readUsers;
  Timestamp createdAt;

  Map<String, dynamic> toMap() => {
        'workspaceId': workspaceId,
        'roomId': roomId,
        'contentId': contentId,
        'createUserId': createUserId,
        'readUsers': readUsers,
        'createdAt': createdAt,
      };
}
