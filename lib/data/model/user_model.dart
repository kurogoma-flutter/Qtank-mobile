// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    this.imageUrl,
    this.belong,
    this.position,
    required this.joinedWorkspaces,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        name: data['name'],
        email: data['email'],
        uid: data['uid'],
        imageUrl: data['imageUrl'],
        belong: data['belong'],
        position: data['position'],
        joinedWorkspaces: List<String>.from(data['joinedWorkspaces']),
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

  factory UserModel.initialData() => UserModel(
        name: '',
        email: '',
        uid: const Uuid().v4(),
        imageUrl: '',
        belong: '',
        position: '',
        joinedWorkspaces: [],
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  String name;
  String email;
  String uid;
  String? imageUrl;
  String? belong;
  String? position;
  List<String> joinedWorkspaces;
  Timestamp createdAt;
  Timestamp updatedAt;

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'uid': uid,
        'imageUrl': imageUrl,
        'belong': belong,
        'position': position,
        'joinedWorkspaces': joinedWorkspaces,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
