import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/data/repository/app_setting_repository.dart';

import '../../constants/enum.dart';
import '../model/app_setting_model.dart';

// TODO: パフォーマンス改善必要
final appSettingServiceProvider =
    Provider((ref) => AppSettingService._(ref.watch(appSettingRepository)));

class AppSettingService {
  AppSettingService._(
    this._appSettingRepository,
  );

  final AppSettingRepository _appSettingRepository;

  /// SharedPreferenceにデータを保存
  Future<void> setAppSetting(AppSettingModel appSetting, String key) async {
    await _appSettingRepository.setAppSetting(convertString(appSetting), key);
  }

  String convertString(AppSettingModel appSetting) {
    return '{"noticeNewMessage":${appSetting.noticeNewMessage},"noticeNewMember":${appSetting.noticeNewMember},"theme":"${themeToStrong(appSetting.theme)}"}';
  }

  String themeToStrong(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
      default:
        return 'dark';
    }
  }

  AppThemeMode stringToTheme(String theme) {
    switch (theme) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
        return AppThemeMode.system;
      default:
        return AppThemeMode.dark;
    }
  }

  /// SharedPreferenceからデータを取得
  Future<AppSettingModel?> getAppSetting(String key) async {
    final appSetting = await _appSettingRepository.getAppSetting(key);
    // nullチェック
    if (appSetting == null) {
      return null;
    }

    Map map = jsonDecode(appSetting);
    final Map<String, dynamic> date = {
      'noticeNewMessage': map['noticeNewMessage'],
      'noticeNewMember': map['noticeNewMember'],
      'theme': stringToTheme(map['theme']),
    };
    return AppSettingModel.fromJson(date);
  }
}
