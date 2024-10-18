import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToCache(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> loadFromCache(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<bool> removeFromCache(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}
