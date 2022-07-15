import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferencesを使用して、データを保存するDataSource
/// 
/// [key] : SharedPreferencesのキー
/// 
/// [value] : 保存する値
Future<void> setString(String key, dynamic value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final saveData = jsonEncode(value);
  prefs.setString(key, saveData);
}

/// SharedPreferencesを使用して、データを取得するDataSource
/// 
/// [key] : SharedPreferencesのキー
/// 
/// json形式で保存されている値を取得する。
Future<dynamic> getString(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final sadeData = prefs.getString(key);
  sadeData != null ? jsonDecode(sadeData) : null;
}