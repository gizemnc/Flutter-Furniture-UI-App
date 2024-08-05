// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_furniture_app/constants/constants.dart';
import 'package:flutter_furniture_app/model/user_model.dart';
import 'package:flutter_furniture_app/pages/email_password_signin_up.dart';
import 'package:flutter_furniture_app/pages/homepage_guest.dart';
import 'package:flutter_furniture_app/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  void _guestLogin() async {
  final userModel = Provider.of<UserViewModel>(context, listen: false);
  try {
    UserModel user = await userModel.signInAnonymously();
    if (kDebugMode) {
      print("Oturum açan userid = ${user.userID}");
    }
    // Misafir giriş yaptıktan sonra yönlendirme işlemi
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (context) => GuestHomePage(user: user)),
    );
  } catch (e) {
    if (kDebugMode) {
      print("An error occurred during sign-in: $e");
    }
  }
}


  void _logInWithGoogle(BuildContext context) async {
    final userModel = Provider.of<UserViewModel>(context, listen: false);
    try {
      UserModel user = await userModel.signInWithGoogle();
      if (kDebugMode) {
        print("Oturum açan userid = ${user.userID}");
      }
      // Oturum açıldıktan sonra yönlendirme veya başka işlemler yapabilirsiniz
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred during sign-in: $e");
      }
    }
  }

  void _logInWithFacebook(BuildContext context) async {
    final userModel = Provider.of<UserViewModel>(context, listen: false);
    try {
      UserModel user = await userModel.signInWithFacebook();
      if (kDebugMode) {
        print("Oturum açan userid = ${user.userID}");
      }
      // Oturum açıldıktan sonra yönlendirme veya başka işlemler yapabilirsiniz
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred during sign-in: $e");
      }
    }
  }

  void _logInWithEmailAndPassword(BuildContext context) {
    Navigator.of(context).push(CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (context) => const EmailPasswordSignIn(),
    ));
  }

  final Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage("assets/images/login.jpg"),
            fit: BoxFit.cover,
            width: double.infinity, // double.maxFinite yerine
            height: double.infinity, // double.maxFinite yerine
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
            child: Card(
              elevation: 20,
              color: Colors.white.withOpacity(0.7),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: const SizedBox(
                height: 510,
                width: 360,
              ),
            ),
          ),
          Stack(
            children: [
              Positioned(
                top: 240,
                left: 110,
                child: Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Furniture UI App", style: Constants.loginHeadTitle),
                      const SizedBox(height: 20),
                      Text("Sign in", style: Constants.loginTitle),
                    ],
                  ),
                ),
              ),
              const Positioned(
                top: 135,
                left: 160,
                child: Align(
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 90,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 380,
            right: 38,
            child: _loginButtonsBuild(),
          ),
        ],
      ),
    );
  }

  Column _loginButtonsBuild() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _logInWithGoogle(context),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 43,
                      width: 310,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 105,
                child: Text(
                  "Sign in with Google",
                  style: Constants.loginPageButtonTitle,
                ),
              ),
              Positioned(
                top: 13,
                left: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    height: 30,
                    "assets/images/google-icon.png",
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _logInWithFacebook(context),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 128, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 43,
                      width: 310,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 98,
                child: Text(
                  "Sign in with Facebook",
                  style: Constants.loginPageButtonTitle,
                ),
              ),
              Positioned(
                top: 10,
                left: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    height: 29,
                    "assets/images/Facebook-icon.png",
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _logInWithEmailAndPassword(context),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 253, 197, 106),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 43,
                      width: 310,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 64,
                child: Text(
                  "Sign in with email and Password",
                  style: Constants.loginPageButtonTitle,
                ),
              ),
              const Positioned(
                top: 13,
                left: 15,
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 253, 197, 106),
                  child: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: _guestLogin,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 196, 136, 156),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 43,
                      width: 310,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 80,
                child: Text(
                  "Sign in with guest account",
                  style: Constants.loginPageButtonTitle,
                ),
              ),
              const Positioned(
                top: 13,
                left: 15,
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 196, 136, 156),
                  child: Icon(
                    Icons.people_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>const EmailPasswordSignIn()));
          },
          child: Text(
            "If you don't have an account please sign up!",
            style: TextStyle(
              color: _textColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
