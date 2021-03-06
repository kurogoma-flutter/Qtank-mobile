// ð¦ Flutter imports:

// ð¦ Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cloudFirestoreServiceProvider = Provider<CloudFirestoreService>(
  (_) => CloudFirestoreService(),
);

class CloudFirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// Firestoreã«ãã¼ã¿ãæ°è¦ç»é²ãã
  ///
  /// [path] : ã³ã¬ã¯ã·ã§ã³ã®ãã¹
  ///
  /// [data] : ä¿å­ãããã¼ã¿ã¢ãã«
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _firebaseFirestore.collection(path);
    await reference.add(data);
  }

  /// Firestoreã«ä¸æã®ãã¼ã¿ãç»é²ãã
  ///
  /// [path] : ãã­ã¥ã¡ã³ãã®ãã¹
  ///
  /// [data] : ä¿å­ãããã¼ã¿ã¢ãã«
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    final reference = _firebaseFirestore.doc(path);
    await reference.set(
      data,
      SetOptions(merge: merge),
    );
  }

  /// Firestoreã«ä¸æã®ãã¼ã¿ãç»é²ãã
  ///
  /// [path] : ãã­ã¥ã¡ã³ãã®ãã¹
  ///
  /// [data] : ä¿å­ãããã¼ã¿ã¢ãã«s
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _firebaseFirestore.doc(path);
    await reference.update(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = _firebaseFirestore.doc(path);
    await reference.delete();
  }

  Future<List<T>> collectionFuture<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
  }) async {
    Query<Map<String, dynamic>> query = _firebaseFirestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map(
          (snapshot) => builder(snapshot.data(), snapshot.id),
        )
        .where((value) => value != null)
        .toList();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchDocumentSnapshot({
    required String path,
  }) {
    final reference = _firebaseFirestore.doc(path);
    return reference.get();
  }
}
