import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreference{
  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userEmail") ?? null;
  }

  Future<bool> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("userEmail", email);
  }
}
var sharedPreference = UserSharedPreference();