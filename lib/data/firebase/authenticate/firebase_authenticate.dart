import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cloudFirestoreServiceProvider = Provider<FirebaseAuthService>(
  (_) => FirebaseAuthService(),
);

class FirebaseAuthService {
  FirebaseAuthService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Firebase Authenticationに新規登録する
  ///
  /// [email] : メールアドレス
  ///
  /// [password] : パスワード
  ///
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Firebase Authenticationにログインする
  ///
  /// [email] : メールアドレス
  ///
  /// [password] : パスワード
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Firebase Authenticationからログアウトする
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Firebase Authenticationからログインしているユーザーを取得する
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  /// Firebaseのログイン状態を監視する
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}
