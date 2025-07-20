import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  AuthProvider() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await StorageService.getBool(AppConstants.loginKey);
    if (isLoggedIn) {
      final userJson = await StorageService.getString(AppConstants.userKey);
      if (userJson != null) {
        _user = User.fromJson(json.decode(userJson));
        notifyListeners();
      }
    }
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await ApiService.login(username, password);
      if (user != null) {
        _user = user;
        await StorageService.setBool(AppConstants.loginKey, true);
        await StorageService.setString(
          AppConstants.userKey, 
          json.encode(user.toJson())
        );
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('Login error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    _user = null;
    await StorageService.remove(AppConstants.loginKey);
    await StorageService.remove(AppConstants.userKey);
    notifyListeners();
  }

  Future<bool> register(String email, String password, String firstName, String lastName) async {
    _isLoading = true;
    notifyListeners();

    // Mock registration - in real app, call API
    await Future.delayed(Duration(seconds: 1));
    
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch,
      email: email,
      username: email,
      firstName: firstName,
      lastName: lastName,
      phone: '1234567890',
    );

    _user = user;
    await StorageService.setBool(AppConstants.loginKey, true);
    await StorageService.setString(
      AppConstants.userKey, 
      json.encode(user.toJson())
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }
}