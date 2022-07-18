// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class InquiryModel {
  InquiryModel({
    required this.inquiryId,
    required this.userName,
    required this.userId,
    required this.userEmail,
    required this.inquiryType,
    required this.inquiryContent,
    required this.createdAt,
  });

  factory InquiryModel.fromMap(Map<String, dynamic> data) => InquiryModel(
        inquiryId: data['inquiryId'],
        userName: data['userName'] as String,
        userId: data['userId'] as String,
        userEmail: data['userEmail'] as String,
        inquiryType: data['inquiryType'] as String,
        inquiryContent: data['inquiryContent'] as String,
        createdAt: data['createdAt'] as Timestamp,
      );

  factory InquiryModel.initialData() => InquiryModel(
        inquiryId: const Uuid().v4(),
        userName: '',
        userId: FirebaseAuth.instance.currentUser!.uid,
        userEmail: FirebaseAuth.instance.currentUser!.email!,
        inquiryType: '',
        inquiryContent: '',
        createdAt: Timestamp.now(),
      );

  final String inquiryId;
  String userName;
  String userId;
  String userEmail;
  String inquiryType;
  String inquiryContent;
  Timestamp createdAt;

  Map<String, dynamic> toMap() => {
        'inquiryId': inquiryId,
        'userName': userName,
        'userId': userId,
        'userEmail': userEmail,
        'inquiryType': inquiryType,
        'inquiryContent': inquiryContent,
        'createdAt': createdAt,
      };
}
