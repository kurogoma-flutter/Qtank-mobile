// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:

final inquiryPageViewModelProvider =
    ChangeNotifierProvider<InquiryPageViewModel>(
  (ref) {
    return InquiryPageViewModel();
  },
);

class InquiryPageViewModel extends ChangeNotifier {
  InquiryPageViewModel();

  /// 状態を表す変数
  String inquiryType = '選択してください';
  String inquiryContent = '';
  bool isSending = false;

  /// 状態を更新するメソッド
  void setInquiryType(value) {
    inquiryType = value;
    notifyListeners();
  }

  void setInquiryContent(value) {
    inquiryContent = value;
    notifyListeners();
  }

  Future<void> sendInquiry() async {
    // 送信処理
    isSending = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    isSending = false;
    notifyListeners();
  }
}
