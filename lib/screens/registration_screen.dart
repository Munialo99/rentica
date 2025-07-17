import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/res/app_images.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/widgets/buttons/social_sign_in_section.dart';
import 'package:rentica/providers/auth_providers.dart';
import 'package:rentica/base/widgets/custom_text_field.dart';
import 'package:rentica/providers/auth_providers.dart';
import 'package:rentica/services/auth_service.dart';

class RegistrationScreen extends ConsumerWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool obscurePassword = ref.watch(obscurePasswordProvider);
    final AuthService authService = ref.watch(authServiceProvider);

    void showSnackBar(String message, {bool isError = false}) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    Future<void> _handleRegister() async {
      final String fullName = _fullNameController.text.trim();
      final String email = _emailController.text.trim();
      final String phoneNumber = _phoneController.text.trim();
      final String password = _passwordController.text.trim();

      if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
        showSnackBar('Please fill in all fields.', isError: true);
        return;
      }

      // Basic email validation
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        showSnackBar('Please enter a valid email address.', isError: true);
        return;
      }

      // Password strength (example: at least 6 characters)
      if (password.length < 6) {
        showSnackBar('Password must be at least 6 characters long.', isError: true);
        return;
      }

      try {
        // Prepare user data for the profile table
        final Map<String, dynamic> userData = {
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'profileImageUrl': null,
          'accountType': 'Standard',
          'memberSince': DateTime.now().toIso8601String(),
          'location': null,
          'bio': null,
          'totalTripsCompleted': 0,
          'dob': null,
          'gender': null,
          'mpesaNumber': null,
        };

        await authService.signUp(email, password, userData);
        showSnackBar('Registration successful! Please check your email for verification.');

        // Navigate to sign-in screen or home screen after successful registration
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/sign_in_screen');
        }
      } catch (e) {
        showSnackBar('Registration Failed: ${e.toString()}', isError: true);
      }
    }

    /*Future<void> handleGoogleSignIn() async {
      try {
        await authService.signInWithGoogle();
        showSnackBar('Successfully signed in with Google!');
        // Navigate to the main app shell after successful login
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      } catch (e) {
        showSnackBar('Google Sign-In Failed: ${e.toString()}', isError: true);
      }
    }*/

    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            key: const ValueKey('RegistrationScreenSliverAppBar'),
            backgroundColor: Colors.transparent,
            expandedHeight: MediaQuery.of(context).size.height * 0.15,
            floating: false,
            pinned: true,
            centerTitle: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background Image
                    Image.network(
                      AppImages.signInAppBarBackground,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: AppStyles.darkBlueApp);
                      },
                    ),
                    // Semi-transparent overlay
                    Container(
                      color: Colors.black.withValues(alpha: 0.65),
                    ),
                    // App Bar Text
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Rentica\n',
                              style: AppStyles.headlineStyle4.copyWith(color: AppStyles.whiteColor),
                            ),
                            TextSpan(
                              text: 'Driven by Trust, Powered by Precision.',
                              style: AppStyles.textStyle4.copyWith(
                                color: AppStyles.whiteColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SliverList for the rest of the form content
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: AppStyles.headlineStyle4,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create your account',
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyle4.copyWith(color: AppStyles.textDarkGrey),
                      ),
                      const SizedBox(height: 20),
                      // Full Name/Username Input Field
                      buildCustomTextField(
                        controller: _fullNameController,
                        hintText: 'Full Name',
                        icon: AppIcons.personOutline,
                      ),
                      const SizedBox(height: 20),
                      //Email Address
                      buildCustomTextField(
                        controller: _emailController,
                        hintText: 'Email Address',
                        icon: AppIcons.email,
                      ),
                      const SizedBox(height: 20),
                      //Phone Number
                      buildCustomTextField(
                        controller: _phoneController,
                        hintText: 'Phone Number',
                        icon: AppIcons.email,
                      ),
                      const SizedBox(height: 20),
                      // Password Input Field
                      buildCustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        icon: AppIcons.lockOutline,
                        isPassword: true,
                        obscureText: obscurePassword,
                        onSuffixIconTap: () {
                          ref.read(obscurePasswordProvider.notifier).state = !obscurePassword;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Login Button
                      ElevatedButton(
                        onPressed: () {
                          _handleRegister;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyles.primaryColor,
                          foregroundColor: AppStyles.whiteColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      //Social Sign In

                      SocialSignInSection(
                        //onGoogleSignIn: handleGoogleSignIn,
                      ),
                      const SizedBox(height: 30),

                      // Don't have account? Sign up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account?",
                            style: AppStyles.textStyle4.copyWith(color: AppStyles.textDarkGrey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/sign_in_screen');
                            },
                            child: Text(
                              'Log In',
                              style: AppStyles.textStyle.copyWith(color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}