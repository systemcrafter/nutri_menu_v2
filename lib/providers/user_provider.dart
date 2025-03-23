//user_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String? _userName;
  String? _userEmail;

  String? get userName => _userName;
  String? get userEmail => _userEmail;

  Future<void> loadUserName() async {
    _userName = await getUserName();
    notifyListeners();
  }

  void setUser(String? name, String? email) {
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }

  void clearUser() {
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }
}
