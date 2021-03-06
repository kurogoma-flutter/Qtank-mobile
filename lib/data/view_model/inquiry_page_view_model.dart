// ð¦ Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ð¦ Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/data/model/inquiry_model.dart';

// ð Project imports:

final inquiryPageViewModelProvider =
    ChangeNotifierProvider<InquiryPageViewModel>(
  (ref) {
    return InquiryPageViewModel();
  },
);

class InquiryPageViewModel extends ChangeNotifier {
  InquiryPageViewModel();

  /// ç¶æãè¡¨ãå¤æ°
  String inquiryType = 'é¸æãã¦ãã ãã';
  String inquiryContent = '';
  bool isSending = false;

  /// ç¶æãæ´æ°ããã¡ã½ãã
  void setInquiryType(value) {
    inquiryType = value;
    notifyListeners();
  }

  void setInquiryContent(value) {
    inquiryContent = value;
    notifyListeners();
  }

  Future<void> sendInquiry() async {
    // ã­ã¼ãã£ã³ã°ãªã³
    isSending = true;
    notifyListeners();
    // ã¦ã¼ã¶ã¼ååå¾
    final userName = await fetchUserName();
    // ã¢ãã«ã«ã»ãã
    final InquiryModel inquiryModel = InquiryModel.initialData();
    inquiryModel.userName = userName;
    inquiryModel.inquiryType = inquiryType;
    inquiryModel.inquiryContent = inquiryContent;
    // Firebaseã«æç¨¿å¦ç
    await FirebaseFirestore.instance
        .collection('inquiry')
        .doc(inquiryModel.inquiryId)
        .set(inquiryModel.toMap());
    // å¤æ°ã®ã¯ãªã¢
    inquiryType = 'é¸æãã¦ãã ãã';
    inquiryContent = '';
    // ã­ã¼ãã£ã³ã°ãªã
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
