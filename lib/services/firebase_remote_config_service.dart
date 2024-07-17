import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  // Default values if fetch fails
  static const defaults = {
    'display_full_email': false,
  };

  bool get displayFullEmail => _remoteConfig.getBool('display_full_email');

  Future<void> initialise() async {
    fetchAndActivate();
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
  }

  Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.fetch();
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print('Error fetching remote config: $e');
    }
  }
}
