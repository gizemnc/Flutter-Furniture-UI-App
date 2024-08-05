import 'package:flutter_furniture_app/model/user_model.dart';
import 'package:flutter_furniture_app/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  final String _userID = "123123123123123123123";
  final String _email = "testuser@example.com"; // Example email address
  final String _password = "password"; // Example password

  @override
  Future<UserModel> currentUser() async {
    return Future.value(UserModel(userID: _userID, email: _email));
  }

  @override
  Future<UserModel> signInAnonymously() async {
    // Simulate a delay to mimic a real-world sign-in process
    return Future.delayed(
      const Duration(seconds: 2),
      () => UserModel(userID: _userID, email: _email),
    );
  }

  @override
  Future<bool> signOut() async {
    // Simulate sign-out process
    return Future.value(true);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    // Simulate Google sign-in
    // Return a dummy user or throw an exception
    throw UnimplementedError('Google sign-in is not implemented');
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    // Simulate Facebook sign-in
    // Return a dummy user or throw an exception
    throw UnimplementedError('Facebook sign-in is not implemented');
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    // Simulate a delay and user verification
    if (email == _email && password == _password) {
      return Future.delayed(
        const Duration(seconds: 2),
        () => UserModel(userID: _userID, email: email),
      );
    } else {
      throw Exception('Invalid email or password');
    }
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(String email, String password) async {
    // Simulate user creation
    if (email.isNotEmpty && password.isNotEmpty) {
      return Future.delayed(
        const Duration(seconds: 2),
        () => UserModel(userID: _userID, email: email),
      );
    } else {
      throw Exception('Invalid email or password');
    }
  }
}
