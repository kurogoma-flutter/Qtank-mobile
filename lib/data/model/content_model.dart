// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ContentModel {
  ContentModel({
    required this.workspaceId,
    required this.genreId,
    required this.roomId,
    required this.contentId,
    required this.contentText,
    required this.uid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContentModel.fromMap(Map<String, dynamic> data) => ContentModel(
        workspaceId: data['workspaceId'],
        genreId: data['genreId'],
        roomId: data['roomId'],
        contentId: data['contentId'],
        contentText: data['contentText'],
        uid: data['uid'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

  factory ContentModel.initialData() => ContentModel(
        workspaceId: '',
        genreId: '',
        roomId: '',
        contentId: const Uuid().v4(),
        contentText: '',
        uid: FirebaseAuth.instance.currentUser!.uid,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  String workspaceId;
  String genreId;
  String roomId;
  String contentId;
  String contentText;
  String uid;
  Timestamp createdAt;
  Timestamp updatedAt;

  Map<String, dynamic> toMap() => {
        'workspaceId': workspaceId,
        'genreId': genreId,
        'roomId': roomId,
        'contentId': contentId,
        'contentText': contentText,
        'uid': uid,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
