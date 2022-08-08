// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class InquiryModel {
  InquiryModel({
    required this.notificationId,
    required this.targetUserId,
    required this.summary,
    required this.notificationTitle,
    required this.notificationDetail,
    required this.isRead,
    required this.createdAt,
  });

  factory InquiryModel.fromMap(Map<String, dynamic> data) => InquiryModel(
        notificationId: data['notificationId'] as String,
        targetUserId: data['targetUserId'] as String,
        summary: data['summary'] as String,
        notificationTitle: data['notificationTitle'] as String,
        notificationDetail: data['notificationDetail'] as String,
        isRead: data['isRead'] as bool,
        createdAt: data['createdAt'] as Timestamp,
      );

  factory InquiryModel.initialData() => InquiryModel(
        notificationId: const Uuid().v4(),
        targetUserId: '',
        summary: '',
        notificationTitle: '',
        notificationDetail: '',
        isRead: false,
        createdAt: Timestamp.now(),
      );

  final String notificationId;
  String targetUserId;
  String summary;
  String notificationTitle;
  String notificationDetail;
  bool isRead;
  Timestamp createdAt;

  Map<String, dynamic> toMap() => {
        'notificationId': notificationId,
        'targetUserId': targetUserId,
        'summary': summary,
        'notificationTitle': notificationTitle,
        'notificationDetail': notificationDetail,
        'isRead': isRead,
        'createdAt': createdAt,
      };
}
