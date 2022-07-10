// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  RoomModel({
    required this.name,
    required this.roomId,
    required this.workspaceId,
    required this.members,
    required this.adminMembers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomModel.fromMap(Map<String, dynamic> data) => RoomModel(
        name: data['name'],
        roomId: data['roomId'],
        workspaceId: data['workspaceId'],
        members: List<String>.from(data['members']),
        adminMembers: List<String>.from(data['adminMembers']),
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

  factory RoomModel.initialData() => RoomModel(
        name: '',
        roomId: '',
        workspaceId: '',
        members: [],
        adminMembers: [],
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  String name;
  String roomId;
  String workspaceId;
  List<String> members;
  List<String> adminMembers;
  Timestamp createdAt;
  Timestamp updatedAt;

  Map<String, dynamic> toMap() => {
        'name': name,
        'roomId': roomId,
        'workspaceId': workspaceId,
        'members': members,
        'adminMembers': adminMembers,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
