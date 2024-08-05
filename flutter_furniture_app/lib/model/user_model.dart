import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String userID;
  final String? email;
  final bool isAnonymous;

  UserModel({
    required this.userID,
    this.email,
    this.isAnonymous = false, // Varsayılan olarak false
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      userID: user.uid,
      email: user.email,
      isAnonymous: user.isAnonymous,
    );
  }
}
