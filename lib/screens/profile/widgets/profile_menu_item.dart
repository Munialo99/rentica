
import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: AppStyles.primaryColor),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppStyles.primaryColor),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}