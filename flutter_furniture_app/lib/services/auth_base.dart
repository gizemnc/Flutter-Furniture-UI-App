import 'package:flutter_furniture_app/model/user_model.dart';

abstract class AuthBase {
  Future<UserModel> currentUser();
  Future<UserModel> signInAnonymously();
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> createUserWithEmailAndPassword(String email, String password);
  Future<bool> signOut();
}
