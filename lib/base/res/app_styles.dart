import 'package:flutter/material.dart';

Color primary = const Color(0xFF00A6FB);
Color secondary = const Color(0xFF006494);
Color steelBlue = const Color(0xFF0582CA);
Color linkWhite = const Color(0xFFECF3F9);

class AppStyles{
  // Colors
  static Color primaryColor = primary;
  static Color secondaryColor = secondary;
  static Color bgColor = linkWhite;
  static Color whiteColor = Colors.white;
  static Color textWhite = Colors.white;
  static Color textBlack = Colors.black45;
  static Color textGrey = Colors.grey.shade600;

  //Text styles
  static TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textBlack);
  static TextStyle textStyle2 = TextStyle(fontSize: 14, color: textGrey);

  static TextStyle headlineStyle1 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: textBlack);
  static TextStyle headlineStyle2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: textBlack);
  static TextStyle headlineStyle3 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textBlack);
}