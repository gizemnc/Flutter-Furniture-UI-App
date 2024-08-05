import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants{
  Constants._(); // Bu syntax artık bu sınıftan kimsenin nesne üretemeyeceği anlamına gelir.



  static TextStyle loginTextStyle = GoogleFonts.dancingScript(
    fontSize: 60,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle subTitleTextStyle = GoogleFonts.openSans(
    color: Colors.white,
     fontSize: 15,
     fontWeight: FontWeight.w400
  );
  static TextStyle subTitleDetailsTextStyle = GoogleFonts.openSans(
    color: Colors.black,
     fontSize: 15,
     fontWeight: FontWeight.w400
  );
  static TextStyle settingsAndCartTextStyle = GoogleFonts.openSans(
    color: Colors.black,
     fontSize: 16,
     fontWeight: FontWeight.w600
  );
  static TextStyle settingsAndCartTitleStyle = GoogleFonts.openSans(
    color: Colors.white,
     fontSize: 25,
     fontWeight: FontWeight.w600
  );
  static TextStyle loginHeadTitle = GoogleFonts.bebasNeue(
    fontSize: 35,
    fontWeight: FontWeight.w700
  );
  static TextStyle loginTitle = GoogleFonts.openSans(
    fontSize: 20,
    fontWeight: FontWeight.w300
  );
  static TextStyle loginPageButtonTitle = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.bold
  );
  static TextStyle emailSignInAppBarTitle = GoogleFonts.roboto(
    fontSize: 27,
    fontWeight: FontWeight.bold
  );
    static TextStyle productTitleStyle = GoogleFonts.openSans(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle productRatingStyle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle productPriceStyle = GoogleFonts.openSans(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );

  static TextStyle oldPriceStyle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.red,
    decoration: TextDecoration.lineThrough,
  );

  static TextStyle savingsStyle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );


  static TextStyle buttonStyle = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}