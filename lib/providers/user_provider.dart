import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  
  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
  
  void clearUser() {
    _user = null;
    notifyListeners();
  }
  
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;
  
  bool get isAdmin => _user != null && (_user!.role == 'admin' || _user!.role == 'owner');
  
  bool get isOwner => _user != null && _user!.role == 'owner';
}
