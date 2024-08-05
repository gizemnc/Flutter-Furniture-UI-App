import 'package:flutter/material.dart';
import 'package:flutter_furniture_app/pages/homepage.dart';
import 'package:flutter_furniture_app/pages/homepage_guest.dart';
import 'package:flutter_furniture_app/pages/login_page.dart';
import 'package:flutter_furniture_app/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserViewModel>(context);

    // Kullanıcı durumu kontrolü
    if (userModel.state == ViewState.idle) {
      // Kullanıcı giriş yapmamış
      if (userModel.user == null) {
        return const LoginPage();
      } else {
        // Kullanıcı anonim mi kontrolü
        if (userModel.user!.isAnonymous) {
          return GuestHomePage(user: userModel.user!); // Misafir kullanıcı sayfası
        } else {
          return HomePage(user: userModel.user!); // Normal kullanıcı sayfası
        }
      }
    } else {
      // Yükleniyor durumu
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
