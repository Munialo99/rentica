import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/res/app_images.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/widgets/buttons/social_sign_in_section.dart';
import 'package:rentica/providers/auth_providers.dart';
import 'package:rentica/base/widgets/custom_text_field.dart';
import 'package:rentica/services/auth_service.dart';

class SignInScreen extends ConsumerWidget {
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool rememberMe = ref.watch(rememberMeProvider);
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

    Future<void> _handleEmailSignIn() async {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        showSnackBar('Please enter both email and password.', isError: true);
        return;
      }

      try {
        await authService.signIn(email, password);
        showSnackBar('Successfully signed in!');
        if (context.mounted) { // Check if widget is still mounted before navigation
          Navigator.of(context).pushReplacementNamed('/');
        }
      } catch (e) {
        showSnackBar('Login Failed: ${e.toString()}', isError: true);
      }
    }

    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            key: const ValueKey('SignInScreenSliverAppBar'),
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
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: AppStyles.headlineStyle4,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Login to your account',
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyle4.copyWith(color: AppStyles.textDarkGrey),
                      ),
                      const SizedBox(height: 20),
                      // Email Address
                      buildCustomTextField(
                        controller: _emailController,
                        hintText: 'Email Address',
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
                      const SizedBox(height: 10),
                      // Remember Me and Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (bool? newValue) {
                                  ref.read(rememberMeProvider.notifier).state = newValue!;
                                },
                                activeColor: AppStyles.primaryColor,
                                checkColor: AppStyles.whiteColor,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                'Remember Me',
                                style: AppStyles.textStyle4.copyWith(color: AppStyles.textDarkGrey),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Implement forgot password logic
                              print('Forgot Password?');
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: AppStyles.textStyle.copyWith(color: AppStyles.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Login Button
                      ElevatedButton(
                        onPressed: _handleEmailSignIn,
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
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      //Social Sign In

                      SocialSignInSection(),
                      const SizedBox(height: 30),

                      // Don't have account? Sign up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have account?",
                            style: AppStyles.textStyle4.copyWith(color: AppStyles.textDarkGrey),
                          ),
                          TextButton(
                            onPressed: () {
    Navigator.pushNamed(
    context, '/registration_screen');

                            },
                            child: Text(
                              'Sign up',
                              style: AppStyles.textStyle.copyWith(color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
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