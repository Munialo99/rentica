import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/screens/booking/booking_summary_screen.dart';
import 'package:rentica/screens/car%20details/car_details_screen.dart';
import 'package:rentica/screens/home/home_screen.dart';
import 'package:rentica/screens/favorite/favorite_screen.dart';
import 'package:rentica/screens/chat/chat_screen.dart';
import 'package:rentica/screens/home/screens/popular_vehicles_screen.dart';
import 'package:rentica/screens/profile/profile_screen.dart';
import 'package:rentica/screens/profile/screens/help_center_screen.dart';
import 'package:rentica/screens/profile/screens/my_booking_screen.dart';
import 'package:rentica/screens/profile/screens/payment_methods_screen.dart';
import 'package:rentica/screens/profile/screens/privacy_policy_screen.dart';
import 'package:rentica/screens/profile/screens/settings_screen.dart';
import 'package:rentica/screens/profile/screens/your_profile_screen.dart';
import 'package:rentica/screens/home/screens/trending_vehicles_screen.dart';

class BottomNavItem {
  final IconData icon;
  final String label;
  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;
  final Map<String, WidgetBuilder> routes;

  const BottomNavItem({
    required this.navigatorKey,
    required this.initialRoute,
    required this.routes,
    required this.icon,
    required this.label,
  });
}

final GlobalKey<NavigatorState> homeNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> favoriteNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> chatNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> bookingsNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> profileNavKey = GlobalKey<NavigatorState>();

final List<BottomNavItem> bottomNavItems = [
  BottomNavItem(
    icon: AppIcons.home,
    label: 'Home',
    navigatorKey: homeNavKey,
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreen(),
      '/trending_cars': (context) => const TrendingVehiclesScreen(),
      '/popular_vehicles_screen': (context) => const PopularVehiclesScreen(),
      '/car_detail_screen': (context) => CarDetailsScreen(carData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      '/booking_summary_screen': (context) => BookingSummaryScreen(ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),


    },
  ),
  BottomNavItem(
    icon: AppIcons.favorite,
    label: 'Favorite',
    navigatorKey: favoriteNavKey,
    initialRoute: '/',
    routes: {
      '/': (context) => const FavoriteScreen(),
      '/car_detail_screen': (context) => CarDetailsScreen(carData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      '/booking_summary_screen': (context) => BookingSummaryScreen(ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),

    },
  ),
  BottomNavItem(
    icon: AppIcons.chat,
    label: 'Chat',
    navigatorKey: chatNavKey,
    initialRoute: '/',
    routes: {
      '/': (context) => const ChatScreen(),
    },
  ),
  BottomNavItem(
    icon: AppIcons.bookmarkBorder,
    label: 'Bookings',
    navigatorKey: bookingsNavKey,
    initialRoute: '/',
    routes: {
      '/': (context) => const MyBookingScreen(),
      '/car_detail_screen': (context) => CarDetailsScreen(carData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      '/booking_summary_screen': (context) => BookingSummaryScreen(ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),

    },
  ),
  BottomNavItem(
    icon: AppIcons.personOutline,
    label: 'Profile',
    navigatorKey: profileNavKey,
    initialRoute: '/',
    routes: {
      '/': (context) => const ProfileScreen(),
      '/your_profile_screen': (context) => YourProfileScreen(),
      '/payment_method_screen': (context) => PaymentMethodsScreen(),
      '/settings_screen': (context) => SettingsScreen(),
      '/help_center_screen': (context) => HelpCenterScreen(),
      '/privacy_policy_screen': (context) => PrivacyPolicyScreen(),
      '/my_bookings_screen': (context) => MyBookingScreen(),
      '/car_detail_screen': (context) => CarDetailsScreen(carData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      '/booking_summary_screen': (context) => BookingSummaryScreen(ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),

    },
  ),
];