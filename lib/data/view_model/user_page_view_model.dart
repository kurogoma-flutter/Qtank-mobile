import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersFutureProvider = FutureProvider.autoDispose(
  (ref) => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get(),
);

final userPageViewModelProvider = ChangeNotifierProvider<UserPageViewModel>(
  (ref) {
    return UserPageViewModel();
  },
);

class UserPageViewModel extends ChangeNotifier {
  UserPageViewModel();

  // 状態管理する変数
  String userName = '';
  String email = '';
  String belong = '';
  String position = '';
  String userImagePath = '';

  // 状態を更新するメソッド
  void setUserName(value) {
    userName = value;
    notifyListeners();
  }

  void setEmail(value) {
    email = value;
    notifyListeners();
  }

  void setBelong(value) {
    belong = value;
    notifyListeners();
  }

  void setPosition(value) {
    position = value;
    notifyListeners();
  }

  void setUserImagePath(value) {
    userImagePath = value;
    notifyListeners();
  }
}
