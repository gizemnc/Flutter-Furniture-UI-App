import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_furniture_app/model/user_model.dart';
import 'package:flutter_furniture_app/services/auth_base.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<List<String>> getSignInMethodsForEmail(String email) async {
    try {
      final signInMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return signInMethods;
    } catch (e) {
      debugPrint("Error fetching sign-in methods: $e");
      throw Exception("Error fetching sign-in methods: $e");
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception("No user is currently signed in.");
      }
      return _userModelFromFirebase(user);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching current user: $e");
      }
      rethrow;
    }
  }

  UserModel _userModelFromFirebase(User user) {
    return UserModel(
      userID: user.uid,
      email: user.email ?? '', // Default to an empty string if email is null
    );
  }

  @override
 Future<UserModel> signInAnonymously() async {
  try {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    final user = userCredential.user;
    if (user != null) {
      return UserModel.fromFirebase(user);
    } else {
      throw Exception('Failed to sign in anonymously');
    }
  } catch (e) {
    throw Exception('Error signing in anonymously: $e');
  }
}

  @override
  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
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
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        if (googleAuth.idToken != null && googleAuth.accessToken != null) {
          final UserCredential userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          final User user = userCredential.user!;
          return _userModelFromFirebase(user);
        } else {
          throw Exception("Google authentication tokens are null.");
        }
      } else {
        throw Exception("Google sign-in user is null.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred during Google sign-in: $e");
      }
      throw Exception("An error occurred during Google sign-in: $e");
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      final result = await _facebookLogin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (result.status) {
        case FacebookLoginStatus.success:
          final FacebookAccessToken? accessToken = result.accessToken;
          final AuthCredential credential = FacebookAuthProvider.credential(accessToken!.token);

          final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
          final User user = userCredential.user!;
          return _userModelFromFirebase(user);

        case FacebookLoginStatus.cancel:
          throw Exception("Facebook login was cancelled by the user.");

        case FacebookLoginStatus.error:
          throw Exception("Facebook login failed: ${result.error}");

        default:
          throw Exception("Unknown Facebook login status.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred during Facebook sign-in: $e");
      }
      throw Exception("An error occurred during Facebook sign-in: $e");
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = userCredential.user!;
    return UserModel(
      userID: user.uid,
      email: user.email!,
    );
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = userCredential.user!;
    return UserModel(
      userID: user.uid,
      email: user.email!,
    );
  }
}
