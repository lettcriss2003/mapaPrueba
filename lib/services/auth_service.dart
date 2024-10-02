import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login(String username, String password) {
    if (username == 'admin' && password == 'password') {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}