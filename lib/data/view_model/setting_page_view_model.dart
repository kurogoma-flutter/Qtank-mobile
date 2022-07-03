// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:

final settingPageViewModelProvider =
    ChangeNotifierProvider<SettingPageViewModel>(
  (ref) {
    return SettingPageViewModel();
  },
);

class SettingPageViewModel extends ChangeNotifier {
  SettingPageViewModel();

  /// 状態を表す変数

  /// 状態を更新するメソッド
}
