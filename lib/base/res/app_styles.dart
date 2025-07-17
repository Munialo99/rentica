import 'package:flutter/material.dart';

Color primary = const Color(0xFF00A6FB);
Color secondary = const Color(0xFF006494);
Color steelBlue = const Color(0xFF0582CA);
Color linkWhite = const Color(0xFFECF3F9);
Color darkestBlue = const Color.fromRGBO(5, 25, 35, 1.0);

class AppStyles{
  // Base Colors
  static Color primaryColor = primary;
  static Color darkBlueApp = darkestBlue;
  static Color secondaryColor = secondary;
  static Color bgColor = linkWhite;
  static Color whiteColor = Colors.white;
  static Color textWhite = Colors.white;
  static Color textBlack = Colors.black;
  static Color textGrey = Colors.grey.shade600;
  static Color textDarkGrey = Colors.grey.shade700;
  static Color disabledGrey = Colors.grey.shade200;
  static Color accountVerifiedBadgeColor = const Color(0xFFC9DEFB);
  static Color accountVerifiedIconBadgeColor = Colors.blueAccent;
  static Color cancelRed = Colors.red;

  // Vehicle Type Colors
  static const Color suvColor = Color(0xFF1E88E5);         // Blue
  static const Color sedanColor = Color(0xFF43A047);       // Green
  static const Color hatchbackColor = Color(0xFFF4511E);   // Orange
  static const Color pickupTruckColor = Color(0xFF6D4C41); // Brown
  static const Color vanColor = Color(0xFF3949AB);         // Indigo
  static const Color minivanColor = Color(0xFF00897B);     // Teal
  static const Color luxuryColor = Color(0xFF8E24AA);      // Purple
  static const Color convertibleColor = Color(0xFFE53935); // Red
  static const Color coupeColor = Color(0xFF3949AB);       // Indigo
  static const Color sportsCarColor = Color(0xFFFFB300);   // Amber
  static const Color electricColor = Color(0xFF00ACC1);    // Cyan
  static const Color hybridColor = Color(0xFF43A047);      // Green
  static const Color busColor = Color(0xFF546E7A);         // Blue Grey
  static const Color motorbikeColor = Color(0xFFFB8C00);   // Deep Orange
  static const Color campervanColor = Color(0xFF5E35B1);   // Deep Purple

  //Text styles
  static TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textBlack);
  static TextStyle textStyle2 = TextStyle(fontSize: 14, color: textGrey);
  static TextStyle textStyle3 = TextStyle(fontSize: 14, color: textBlack);
  static TextStyle textStyle4 = TextStyle(fontSize: 16, color: textBlack);

  static TextStyle headlineStyle1 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: textBlack);
  static TextStyle headlineStyle2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: textBlack);
  static TextStyle headlineStyle3 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textBlack);

  //Sign In Page
  static TextStyle headlineStyle4 = TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: primaryColor);

}