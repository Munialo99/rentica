import 'package:flutter/material.dart';
import 'package:rentica/base/data/mock%20data/privacy_policy_data.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/res/app_icons.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(AppIcons.arrowBack, color: AppStyles.textBlack),
        ),
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            color: AppStyles.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppStyles.whiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cancellation Policy Section
            Text(
              'Cancellation Policy',
              style: AppStyles.headlineStyle3.copyWith(
                fontWeight: FontWeight.bold,
                color: AppStyles.primaryColor, // Matching the blue color in the image
              ),
            ),
            const SizedBox(height: 8),
            Text(
              cancellationPolicyText,
              style: AppStyles.textStyle.copyWith(
                fontSize: 14,
                color: AppStyles.textGrey, // Matching the light grey text color
              ),
            ),
            const SizedBox(height: 15), // Spacing between sections

            // Terms & Condition Section
            Text(
              'Terms & Condition',
              style: AppStyles.headlineStyle3.copyWith(
                fontWeight: FontWeight.bold,
                color: AppStyles.primaryColor, // Matching the blue color in the image
              ),
            ),
            const SizedBox(height: 8),
            Text(
              termsAndConditionText,
              style: AppStyles.textStyle.copyWith(
                fontSize: 14,
                color: AppStyles.textGrey, // Matching the light grey text color
              ),
            ),
            const SizedBox(height: 40), // Additional spacing at the bottom
          ],
        ),
      ),
    );
  }
}