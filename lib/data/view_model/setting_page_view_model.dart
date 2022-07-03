// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/constants/enum.dart';

// 🌎 Project imports:
import '../../constants/enum.dart';

final settingPageViewModelProvider =
    ChangeNotifierProvider<SettingPageViewModel>(
  (ref) {
    return SettingPageViewModel();
  },
);

class SettingPageViewModel extends ChangeNotifier {
  SettingPageViewModel();

  /// 状態を表す変数
  bool ableToNoticeAboutNewMessage = true;
  bool ableToNoticeAboutNewMember = true;
  // TODO: デフォルトのEnumにする
  AppThemeMode themeMode = AppThemeMode.dark;

  /// 状態を更新するメソッド
  void updateAbleToSendMessage(bool value) {
    ableToNoticeAboutNewMessage = value;
    notifyListeners();
  }

  void updateAbleToSendMember(bool value) {
    ableToNoticeAboutNewMember = value;
    notifyListeners();
  }

  void updateThemeMode(value) {
    themeMode = value;
    notifyListeners();
  }
}
