// 📦 Package imports:
import 'package:qtank_mobile/constants/enum.dart';

class AppSettingModel {
  AppSettingModel({
    required this.noticeNewMessage,
    required this.noticeNewMember,
    required this.theme,
  });

  factory AppSettingModel.fromMap(Map<String, dynamic> data) => AppSettingModel(
        noticeNewMessage: data['noticeNewMessage'],
        noticeNewMember: data['noticeNewMember'],
        theme: data['theme'],
      );

  factory AppSettingModel.initialData() => AppSettingModel(
        noticeNewMessage: true,
        noticeNewMember: true,
        theme: AppThemeMode.system,
      );

  bool noticeNewMessage;
  bool noticeNewMember;
  AppThemeMode theme;

  Map<String, dynamic> toMap() => {
        'noticeNewMessage': noticeNewMessage,
        'noticeNewMember': noticeNewMember,
        'theme': theme,
      };

  AppSettingModel.fromJson(Map<String, dynamic> json)
      : noticeNewMessage = json['noticeNewMessage'],
        noticeNewMember = json['noticeNewMember'],
        theme = json['theme'];

  Map<String, dynamic> toJson() => {
        'noticeNewMessage': noticeNewMessage,
        'noticeNewMember': noticeNewMember,
        'theme': theme,
      };
}
