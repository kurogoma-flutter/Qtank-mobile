// 🐦 Flutter imports:
import 'package:flutter/material.dart';
// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/constants/enum.dart';
import 'package:qtank_mobile/data/service/app_setting_service.dart';

// 🌎 Project imports:
import '../model/app_setting_model.dart';

final settingPageViewModelProvider =
    ChangeNotifierProvider<SettingPageViewModel>(
  (ref) {
    return SettingPageViewModel(
      ref.watch(
        appSettingServiceProvider,
      ),
    );
  },
);

class SettingPageViewModel extends ChangeNotifier {
  SettingPageViewModel(
    this._appSettingService,
  );
  final AppSettingService _appSettingService;

  /// 状態を表す変数
  bool ableToNoticeAboutNewMessage = true;
  bool ableToNoticeAboutNewMember = true;
  // TODO: デフォルトのEnumにする
  AppThemeMode themeMode = AppThemeMode.dark;

  initialize() {
    getAppSetting();
  }

  /// 状態を更新するメソッド
  void updateAbleToSendMessage(bool value) {
    ableToNoticeAboutNewMessage = value;
    saveAppSetting();
    notifyListeners();
  }

  void updateAbleToSendMember(bool value) {
    ableToNoticeAboutNewMember = value;
    saveAppSetting();
    notifyListeners();
  }

  void updateThemeMode(value) {
    themeMode = value;
    saveAppSetting();
    notifyListeners();
  }

  Future<void> saveAppSetting() async {
    final appSetting = AppSettingModel.initialData();
    appSetting.noticeNewMessage = ableToNoticeAboutNewMessage;
    appSetting.noticeNewMember = ableToNoticeAboutNewMember;
    appSetting.theme = themeMode;
    await _appSettingService.setAppSetting(appSetting, 'appSetting');
  }

  Future<void> getAppSetting() async {
    final appSetting = await _appSettingService.getAppSetting('appSetting');

    if (appSetting != null) {
      ableToNoticeAboutNewMessage = appSetting.noticeNewMessage;
      ableToNoticeAboutNewMember = appSetting.noticeNewMember;
      themeMode = appSetting.theme;
      notifyListeners();
    }
  }
}
