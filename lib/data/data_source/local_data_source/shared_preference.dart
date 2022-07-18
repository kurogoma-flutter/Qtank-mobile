import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceServiceProvider = Provider<SharedPreferenceService>(
  (_) => SharedPreferenceService(),
);

class SharedPreferenceService {
  /// SharedPreferencesを使用して、データを保存するDataSource
  ///
  /// [key] : SharedPreferencesのキー
  ///
  /// [value] : 保存する値
  Future<void> setData(String key, String json) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final saveData = jsonEncode(value);
    prefs.setString(key, json);
  }

  /// SharedPreferencesを使用して、データを取得するDataSource
  ///
  /// [key] : SharedPreferencesのキー
  ///
  /// json形式で保存されている値を取得する。
  Future<dynamic> fetchData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final saveData = prefs.getString(key);
    return saveData;
  }
}
