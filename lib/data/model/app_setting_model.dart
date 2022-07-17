// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qtank_mobile/constants/enum.dart';

class AppSettingModel {
  AppSettingModel({
    required this.noticeNewMessage,
    required this.noticeNewMember,
    required this.theme,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppSettingModel.fromMap(Map<String, dynamic> data) => AppSettingModel(
        noticeNewMessage: data['noticeNewMessage'],
        noticeNewMember: data['noticeNewMember'],
        theme: data['theme'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

  factory AppSettingModel.initialData() => AppSettingModel(
        noticeNewMessage: true,
        noticeNewMember: true,
        theme: AppThemeMode.system,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  bool noticeNewMessage;
  bool noticeNewMember;
  AppThemeMode theme;
  Timestamp createdAt;
  Timestamp updatedAt;

  Map<String, dynamic> toMap() => {
        'noticeNewMessage': noticeNewMessage,
        'noticeNewMember': noticeNewMember,
        'theme': theme,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
