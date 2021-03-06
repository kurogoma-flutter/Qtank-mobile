// ๐ฆ Flutter imports:
import 'package:flutter/material.dart';
// ๐ฆ Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/constants/enum.dart';
import 'package:qtank_mobile/data/service/app_setting_service.dart';

// ๐ Project imports:
import '../../constants/enum.dart';
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

  /// ็ถๆใ่กจใๅคๆฐ
  bool ableToNoticeAboutNewMessage = true;
  bool ableToNoticeAboutNewMember = true;
  // TODO: ใใใฉใซใใฎEnumใซใใ
  AppThemeMode themeMode = AppThemeMode.dark;

  initialize() {
    getAppSetting();
  }

  /// ็ถๆใๆดๆฐใใใกใฝใใ
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
