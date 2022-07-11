// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.imageUrl,
    required this.belong,
    required this.position,
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
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

  factory UserModel.initialData() => UserModel(
        name: '',
        email: '',
        uid: '',
        imageUrl: '',
        belong: '',
        position: '',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  String name;
  String email;
  String uid;
  String imageUrl;
  String belong;
  String position;
  Timestamp createdAt;
  Timestamp updatedAt;

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'uid': uid,
        'imageUrl': imageUrl,
        'belong': belong,
        'position': position,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
