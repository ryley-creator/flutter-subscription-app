import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String subscriptionKey = "isSubscribed";

  static Future<bool> isSubscribed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(subscriptionKey) ?? false;
  }

  static Future<void> saveSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(subscriptionKey, true);
  }
}
