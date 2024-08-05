import 'package:flutter/foundation.dart';
import 'package:flutter_furniture_app/model/user_model.dart';
import 'package:flutter_furniture_app/services/auth_base.dart';
import 'package:flutter_furniture_app/services/fake_auth_service.dart';
import 'package:flutter_furniture_app/services/firebase_auth_service.dart';
import 'package:flutter_furniture_app/services/locator.dart';

enum AppMode {
  // ignore: constant_identifier_names
  DEBUG, // Debug mode when Firebase settings are not configured
  // ignore: constant_identifier_names
  RELEASE // Release mode with Firebase settings
}

class UserRepository implements AuthBase {
  
  final FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  final FakeAuthService _fakeAuthService = locator<FakeAuthService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<UserModel> currentUser() async {
    try {
      if (appMode == AppMode.DEBUG) {
        return await _fakeAuthService.currentUser();
      } else {
        return await _firebaseAuthService.currentUser();
      }
    } catch (e) {
      if (kDebugMode) {
        if (kDebugMode) {
          if (kDebugMode) {
            if (kDebugMode) {
              if (kDebugMode) {
                print("Error fetching current user: $e");
              }
            }
          }
        }
      }
      rethrow;
    }
  }

  @override
  Future<UserModel> signInAnonymously() async {
    try {
      if (appMode == AppMode.DEBUG) {
        return await _fakeAuthService.signInAnonymously();
      } else {
        return await _firebaseAuthService.signInAnonymously();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in anonymously: $e");
      }
      rethrow;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      if (appMode == AppMode.DEBUG) {
        return await _fakeAuthService.signOut();
      } else {
        return await _firebaseAuthService.signOut();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error signing out: $e");
      }
      return false;
    }
  }
  
  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      if (appMode == AppMode.DEBUG) {
        return await _fakeAuthService.signInWithGoogle();
      } else {
        return await _firebaseAuthService.signInWithGoogle();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in with Google: $e");
      }
      rethrow;
    }
  }
  
  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      if (appMode == AppMode.DEBUG) {
        return await _fakeAuthService.signInWithFacebook();
      } else {
        return await _firebaseAuthService.signInWithFacebook();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in with Facebook: $e");
      }
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      if (appMode == AppMode.DEBUG) {
        return await _fakeAuthService.signInWithEmailAndPassword(email, password);
      } else {
        return await _firebaseAuthService.signInWithEmailAndPassword(email, password);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in with email: $e");
      }
      rethrow;
    }
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(String email, String password) async {
    try {
      if (appMode == AppMode.DEBUG) {
        return await _fakeAuthService.createUserWithEmailAndPassword(email, password);
      } else {
        return await _firebaseAuthService.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error creating user with email: $e");
      }
      rethrow;
    }
  }
}
