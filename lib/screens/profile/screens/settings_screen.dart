import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/screens/profile/widgets/profile_menu_item.dart';

// TODO: SETTINGS SCREEN
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          'Settings',
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
      body: Column(
        children: [
          const SizedBox(height: 10),
          ProfileMenuItem(
            icon: AppIcons.notification,
            title: 'Notification Settings',
            onTap: () {
              // TODO: Implement navigation to Notification Settings screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigate to Notification Settings')),
              );
            },
          ),
          ProfileMenuItem(
            icon: AppIcons.lock,
            title: 'Password Manager',
            onTap: () {
              // TODO: Implement navigation to Password Manager screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigate to Password Manager')),
              );
            },
          ),
          ProfileMenuItem(
            icon: AppIcons.delete,
            title: 'Delete Account',
            onTap: () {
              // TODO: Implement Delete Account functionality (e.g., show confirmation dialog)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Show Delete Account Confirmation')),
              );
            },
          ),
        ],
      ),
    );
  }
}