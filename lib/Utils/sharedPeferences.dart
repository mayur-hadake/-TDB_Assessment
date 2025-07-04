

import 'package:shared_preferences/shared_preferences.dart';

class SharedPre {
  removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }


  Future<void> setAccessToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("AccessToken", value);
    print("AccessToken => $value");
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("AccessToken");
  }

  Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('AccessToken');
  }

  Future<void> setRefreshToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("RefreshToken", value);
    print("RefreshToken $value");
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("RefreshToken");
  }

  Future<void> removeRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('RefreshToken');
  }



  //

}
