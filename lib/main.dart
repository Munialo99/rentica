import 'package:flutter/material.dart';
import 'package:rentica/base/widgets/main_app_shell.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/screens/registration_screen.dart';
import 'package:rentica/screens/sign_in_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  /*await migrateUser();*/
  /*await migrateBookings();*/

  runApp(ProviderScope(child: const MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<AuthState>(
        stream: supabase.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              // loading screen
                body: Center(child: CircularProgressIndicator()));
          }

          final AuthState? authState = snapshot.data;
          if (authState?.event == AuthChangeEvent.signedOut ||
              authState?.session == null) {
            return SignInScreen(); // Show sign-in if not logged in
          } else {
            // User is logged in, show the main app shell
            return const MainAppShell();
          }
        },
      ),
      routes: {
        '/registration_screen': (context) => RegistrationScreen(),
      },
    );
  }
  /*Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const MainAppShell(),
      initialRoute: '/sign_in_screen',
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
        '/sign_in_screen': (context) => SignInScreen(),
        '/registration_screen': (context) => RegistrationScreen(),
      },
    );
  }*/
}
