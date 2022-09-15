import 'package:qtank_mobile/data/utility/logger/logger.dart';

class QTankException {
  /// Firebaseの例外処理
  String firebaseException(String code) {
    var message = '';
    // エラーコード別処理
    switch (code) {
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

    return message;
  }
}
