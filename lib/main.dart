import 'package:flutter/material.dart';
import 'package:rentica/base/widgets/main_app_shell.dart';
import 'package:rentica/screens/booking/booking_summary_screen.dart';
import 'package:rentica/screens/car%20details/car_details_screen.dart';
import 'package:rentica/screens/home/home_screen.dart';
import 'package:rentica/screens/home/screens/popular_vehicles_screen.dart';
import 'package:rentica/screens/profile/profile_screen.dart';
import 'package:rentica/screens/profile/screens/help_center_screen.dart';
import 'package:rentica/screens/booking/my_booking_screen.dart';
import 'package:rentica/screens/profile/screens/payment_methods_screen.dart';
import 'package:rentica/screens/profile/screens/privacy_policy_screen.dart';
import 'package:rentica/screens/profile/screens/settings_screen.dart';
import 'package:rentica/screens/profile/screens/your_profile_screen.dart';
import 'package:rentica/screens/home/screens/trending_vehicles_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const MainAppShell(),
      initialRoute: '/',
      routes: {
        //'/': (context) => const HomeScreen(),
        '/': (context) => const MainAppShell(),
        '/trending_cars': (context) => const TrendingVehiclesScreen(),
        '/car_detail_screen': (context) => CarDetailsScreen(carData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/booking_summary_screen': (context) => BookingSummaryScreen(ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/profile_screen': (context) => ProfileScreen(),
        '/your_profile_screen': (context) => YourProfileScreen(),
        '/payment_method_screen': (context) => PaymentMethodsScreen(),
        '/settings_screen': (context) => SettingsScreen(),
        '/help_center_screen': (context) => HelpCenterScreen(),
        '/privacy_policy_screen': (context) => PrivacyPolicyScreen(),
        '/my_bookings_screen': (context) => MyBookingScreen(),
        '/popular_vehicles_screen': (context) => PopularVehiclesScreen(),
      },
    );
  }
}