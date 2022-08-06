// 🐦 Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/data/model/inquiry_model.dart';
import 'package:qtank_mobile/data/model/qa_list_model.dart';

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
    // ローディングオン
    isSending = true;
    notifyListeners();
    // ユーザー名取得
    final userName = await fetchUserName();
    // モデルにセット
    final InquiryModel inquiryModel = InquiryModel.initialData();
    inquiryModel.userName = userName;
    inquiryModel.inquiryType = inquiryType;
    inquiryModel.inquiryContent = inquiryContent;
    // Firebaseに投稿処理
    await FirebaseFirestore.instance
        .collection('inquiry')
        .doc(inquiryModel.inquiryId)
        .set(inquiryModel.toMap());
    // 変数のクリア
    inquiryType = '選択してください';
    inquiryContent = '';
    // ローディングオフ
    isSending = false;
    notifyListeners();
  }

  Future<String> fetchUserName() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.data()!['name']);
  }
}

final qaListFutureProvider = FutureProvider<List<QaListModel>>(
  (ref) => FirebaseFirestore.instance
      .collection('qa_list')
      .orderBy('question', descending: true)
      .get()
      .then((value) =>
          value.docs.map((e) => QaListModel.fromMap(e.data())).toList()),
);
