// 🎯 Dart imports:
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageServiceProvider =
    Provider<FirebaseStorageService>((ref) => FirebaseStorageService());

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  /// [path] : ストレージのパス
  ///
  /// [file] : ストレージに保存する画像ファイル
  ///
  /// 保存後の返り値として保存した画像のURLを返す。
  Future<String> uploadImage(String path, Uint8List file) async {
    final storageRef = _firebaseStorage.ref().child(path);
    try {
      // XFileからUint8Listへ変換してCloudStorageへアップロード
      final UploadTask uploadTask = storageRef.putData(file);
      final snapshot = await Future.value(uploadTask);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return e.toString();
    }
  }

  /// ストレージから画像を削除する
  Future<void> deleteImage(String path) async {
    final storageRef = _firebaseStorage.ref().child(path);
    await storageRef.delete();
  }
}
