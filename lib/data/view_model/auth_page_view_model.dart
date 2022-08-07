// 🐦 Flutter imports:
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qtank_mobile/data/model/user_model.dart';

// 🌎 Project imports:
import '../../presentation/pages/common_components/dialog.dart';
import '../utility/logger/logger.dart';

final authPageProvider = ChangeNotifierProvider<AuthPageViewModel>(
  (ref) {
    return AuthPageViewModel();
  },
);

class AuthPageViewModel extends ChangeNotifier {
  AuthPageViewModel();

  /// 状態を表す変数
  String userName = '';
  String email = '';
  String password = '';
  String belong = '';
  String position = '';
  String userImagePath = '';
  File? file;
  final picker = ImagePicker();
  UserModel userInfo = UserModel.initialData();

  /// 状態を更新するメソッド
  void setUserName(value) {
    userName = value;
    notifyListeners();
  }

  void setEmail(value) {
    email = value;
    notifyListeners();
  }

  void setPassword(value) {
    password = value;
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

  Future<void> loginWithEmail(BuildContext context) async {
    // 未入力の場合とりあえず非活性
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    try {
      // メール/パスワードでログイン
      final auth = FirebaseAuth.instance;

      // ignore: unused_local_variable
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ログインできたら入力操作系をクリアする
      clearUserInfo();

      // ignore: use_build_context_synchronously
      return context.go('/workspace/list');
    } on FirebaseAuthException catch (e) {
      // ログインに失敗した場合
      var message = '';
      // エラーコード別処理
      switch (e.code) {
        case 'invalid-email':
          message = 'メールアドレスが不正です。';
          break;
        case 'wrong-password':
          message = 'パスワードが違います。';
          break;
        case 'user-disabled':
          message = '指定されたユーザーは無効です。';
          break;
        case 'user-not-found':
          message = '指定されたユーザーは存在しません。';
          break;
        case 'operation-not-allowed':
          message = '指定されたユーザーはこの操作を許可していません。';
          break;
        case 'too-many-requests':
          message = '複数回リクエストが発生しました。';
          break;
        case 'email-already-exists':
          message = '指定されたメールアドレスは既に使用されています。';
          break;
        case 'internal-error':
          message = '内部処理エラーが発生しました。';
          break;
        default:
          message = '予期せぬエラーが発生しました。';
      }

      logger.w(message);
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          dialogMessage: message,
        ),
      );
    }
  }

  /// サインアウト処理
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // 管理しているユーザー情報の破棄
      removeCurrentUserInfo();
      // ignore: use_build_context_synchronously
      context.go('/');
    } on FirebaseAuthException catch (e) {
      logger.i('サインアウトに失敗しました');
      logger.i(e.toString());
    }
  }

  /// メール認証：ユーザーログイン
  Future<void> signUp(BuildContext context) async {
    // 未入力の場合とりあえず非活性
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    try {
      final auth = FirebaseAuth.instance;
      // メール/パスワードでユーザー登録
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // コレクションに追加
      addUserCollection(result);
      // そのままログイン => AuthGateへ遷移
      // ignore: use_build_context_synchronously
      loginWithEmail(context);
      return;
    } on FirebaseAuthException catch (e) {
      // TODO(Kurogoma939): エラーハンドリング対応
      // ログインに失敗した場合
      var message = '';
      // エラーコード別処理
      switch (e.code) {
        case 'invalid-email':
          message = 'メールアドレスが不正です。';
          break;
        case 'wrong-password':
          message = 'パスワードが違います。';
          break;
        case 'user-disabled':
          message = '指定されたユーザーは無効です。';
          break;
        case 'user-not-found':
          message = '指定されたユーザーは存在しません。';
          break;
        case 'operation-not-allowed':
          message = '指定されたユーザーはこの操作を許可していません。';
          break;
        case 'too-many-requests':
          message = '複数回リクエストが発生しました。';
          break;
        case 'email-already-exists':
          message = '指定されたメールアドレスは既に使用されています。';
          break;
        case 'internal-error':
          message = '内部処理エラーが発生しました。';
          break;
        default:
          message = '予期せぬエラーが発生しました。';
      }

      logger.w(message);
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          dialogMessage: message,
        ),
      );
    }
  }

  void addUserCollection(UserCredential user) {
    final uid = user.user!.uid;
    // ユーザーモデルセット
    UserModel userModel = UserModel.initialData();
    userModel.uid = uid;
    userModel.name = userName;
    userModel.email = email;
    userModel.imageUrl = userImagePath;
    userModel.belong = belong;
    userModel.position = position;

    final userCollection = FirebaseFirestore.instance.collection('users');
    userCollection.doc(uid).set(userModel.toMap());
  }

  /// エラーメッセージを返し、ダイアログ内で使用
  String validateLoginText() {
    // nullチェック
    if (email.isEmpty) {
      return 'メールアドレスを入力してください';
    } else if (password.isEmpty) {
      return 'パスワードを入力してください';
    }

    // 正規入力
    if (!email.contains('@')) {
      return 'メールアドレスを正しく入力してください';
    }

    if (password.length < 6) {
      return 'パスワードは6文字以上です';
    }

    return '';
  }

  void clearUserInfo() {
    userName = '';
    email = '';
    password = '';
    belong = '';
    position = '';
    userImagePath = '';
    file = null;
    notifyListeners();
  }

  // パスワード再設定メール
  Future sendPasswordResetEmail(String email) async {
    logger.i('パスワード再設定通知開始');
    try {
      // メールアドレスがない場合、自動取得
      if (email.isEmpty) {
        email = FirebaseAuth.instance.currentUser!.email!;
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      logger.i('パスワード再設定通知完了');
    } on FirebaseAuthException {
      logger.w('再設定通知の送信に失敗しました。');
      // 失敗したダイアログ
      return const CustomAlertDialog(dialogMessage: '送信に失敗しました。');
    }
  }

  /// 退会処理
  Future deleteUser(BuildContext context) async {
    try {
      // 退会処理
      var result = await showDialog<bool>(
        context: context,
        builder: (_) {
          return const ConfirmationDialog(
            dialogMessage: '削除してもよろしいですか？',
          );
        },
      );
      User? user = FirebaseAuth.instance.currentUser!;
      if (result != null && result) {
        // usersコレクションから削除する
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();
        // Authenticationから削除
        await user.delete();
        // 全て削除したらログインページへ遷移する
        // ignore: use_build_context_synchronously
        context.go('/auth/login');
      }
    } on FirebaseAuthException {
      logger.w('退会処理に失敗しました。');
    }
  }

  /// --------------------------------------------------
  /// ユーザーアイコン系の処理
  /// --------------------------------------------------

  // ギャラリーから画像を取得
  Future getImageFromGallery() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    // 空の場合終了
    if (image == null) {
      return;
    }
    file = File(userImagePath);
    notifyListeners();
  }

  /// プロフィール編集画面でsユーザーアイコンを変更する処理
  Future setOnlyImage(String imageUrl) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      if (file != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          "imageUrl": imageUrl,
          "updatedAt": Timestamp.now(),
        });
        notifyListeners();
      }
    } on Exception catch (e) {
      logger.w(e);
    }
  }

  /// 画像取得 => Storageに保存 => URLを返す
  Future pickAndStoreImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    await getImageFromGallery();

    try {
      if (file != null) {
        // ファイルをStorageに保存
        final task = await storage.ref('images/$userImagePath').putFile(file!);
        // 保存したファイルのURLを取得
        String imageUrl = await task.ref.getDownloadURL();
        notifyListeners();
        return imageUrl;
      }
    } catch (e) {
      logger.w(e);
    }
  }

  void setCurrentUserInfo(UserModel user) {
    userInfo = user;
  }

  void removeCurrentUserInfo() {
    userInfo = UserModel.initialData();
    notifyListeners();
  }
}
