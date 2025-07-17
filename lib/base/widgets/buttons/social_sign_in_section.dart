import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/res/app_images.dart';
import 'package:rentica/base/res/app_styles.dart';

class SocialSignInSection extends StatelessWidget {
  const SocialSignInSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppStyles.textGrey,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Or continue with',
                style: AppStyles.textStyle,
              ),
            ),
            Expanded(
              child: Divider(
                color: AppStyles.textGrey,
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Social Login Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              iconUrl: AppIcons.googleLogo, // Google icon URL
              onTap: () {
                print('Google login tapped');
                // TODO: Implement Google login
              },
            ),
            SizedBox(width: 30,),
            _buildSocialButton(
              iconUrl: AppIcons.appleLogo, // Apple icon URL (black)
              onTap: () {
                print('Apple login tapped');
                // TODO: Implement Apple login
              },
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to build a social login circular button
  Widget _buildSocialButton({
    required String iconUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60, // Size of the circular button
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white, // White background for the circle
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300, width: 1), // Subtle grey border
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Image.network(
            iconUrl,
            width: 30, // Size of the icon inside the circle
            height: 30,
            errorBuilder: (context, error, stackTrace) {
              // Fallback for network image loading errors
              return const Icon(Icons.error, color: Colors.red);
            },
          ),
        ),
      ),
    );
  }
}