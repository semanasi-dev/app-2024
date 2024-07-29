import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  User? _userUid;

  User? get userUid => _userUid;

  void setUserUid(User? userUid) {
    _userUid = userUid;
    notifyListeners();
  }
}
