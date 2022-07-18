import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/data/data_source/local_data_source/shared_preference.dart';

final appSettingRepository = Provider((ref) =>
    AppSettingRepository._(ref.watch(sharedPreferenceServiceProvider)));

class AppSettingRepository {
  AppSettingRepository._(
    this._sharedPreferenceService,
  );

  final SharedPreferenceService _sharedPreferenceService;

  Future<void> setAppSetting(String jsonData, String key) async {
    await _sharedPreferenceService.setData(
      key,
      jsonData,
    );
  }

  Future<String?> getAppSetting(String key) async {
    final appSetting = await _sharedPreferenceService.fetchData(key);
    return appSetting;
  }
}
