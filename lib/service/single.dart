import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();
  final String version = '.02';
  User? _firebaseUser; // Firebase user instance
  TrainingUser? _apiUser; // Custom API user instance
  bool addingApiRecord = false;
  int selectedScreenIndex = 0;

  // Callback for rebuilding MainScreen
  VoidCallback? rebuildCallback;


  UserSingleton._internal();

  static UserSingleton get instance => _instance;

  User? get firebaseUser => _firebaseUser;
  TrainingUser? get apiUser => _apiUser;

  void setFirebaseUser(User user) {
    _firebaseUser = user;
    printFirebaseIdToken();
  }

  void setAPIUser(TrainingUser user) {
    _apiUser = user;
  }


  void clearUser() {
    _firebaseUser = null;
    _apiUser = null;
  }

  Future<void> printFirebaseIdToken() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final idToken = await user.getIdToken();
      print('Your Firebase ID Token:');
      print(idToken);
    } else {
      print('No user is currently signed in.');
    }
  }
  // Method to notify MainScreen to rebuild
  void notifyRebuild() {
    if (rebuildCallback != null) {
      print(74);
      rebuildCallback!();
    }
  }

}
