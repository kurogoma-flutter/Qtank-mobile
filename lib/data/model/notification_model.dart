// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class NotificationModel {
  NotificationModel({
    required this.notificationId,
    required this.targetUserId,
    required this.summary,
    required this.notificationTitle,
    required this.notificationDetail,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> data) =>
      NotificationModel(
        notificationId: data['notificationId'] as String,
        targetUserId: data['targetUserId'] as String,
        summary: data['summary'] as String,
        notificationTitle: data['notificationTitle'] as String,
        notificationDetail: data['notificationDetail'] as String,
        isRead: data['isRead'] as bool,
        createdAt: data['createdAt'] as Timestamp,
      );

  factory NotificationModel.initialData() => NotificationModel(
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
