import 'package:flutter/material.dart';
import 'package:rentica/base/data/mock%20data/user/user_data.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/screens/profile/widgets/account_badge.dart';
import 'package:rentica/screens/profile/widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userFullName = currentUserData['fullName'] ?? 'User Name';
    final String userProfileImageUrl = currentUserData['profileImageUrl'] ?? '';
    final String userAccountType =
        currentUserData['accountType'] ?? 'Standard Account';

    return Scaffold(
      backgroundColor: Colors.white,
      //App Bar
      appBar: AppBar(
        /*leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(AppIcons.arrowBack, color: AppStyles.textBlack),
        ),*/
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppStyles.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // User Profile Picture and Edit Button
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 85,
                  backgroundImage:
                      NetworkImage(userProfileImageUrl), // Placeholder image
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppStyles.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(5.0),
                      icon: const Icon(AppIcons.edit,
                          color: Colors.white, size: 20),
                      onPressed: () {
                        // TODO: Implement edit profile picture functionality
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // User Name
            Text(
              userFullName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Account Badge
            AccountBadge(
              label: userAccountType,
              icon: AppIcons.verifiedUser,
              backgroundColor: AppStyles.accountVerifiedBadgeColor,
              iconAndTextColor: AppStyles.accountVerifiedIconBadgeColor,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  Divider(height: 1, thickness: 0.5, color: Colors.grey[300]),
            ),

            // Profile Menu Items
            ProfileMenuItem(
              icon: AppIcons.personOutline,
              title: 'Your profile',
              onTap: () {
                Navigator.pushNamed(context, "/your_profile_screen");
              },
            ),
            ProfileMenuItem(
              icon: AppIcons.creditCard,
              title: 'Payment Methods',
              onTap: () {
                Navigator.pushNamed(context, "/payment_method_screen");
              },
            ),
            ProfileMenuItem(
              icon: AppIcons.bookmarkBorder,
              title: 'My Bookings',
              onTap: () {
                Navigator.pushNamed(context, "/my_bookings_screen");
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  Divider(height: 1, thickness: 0.5, color: Colors.grey[300]),
            ),
            ProfileMenuItem(
              icon: AppIcons.settingsOutlined,
              title: 'Settings',
              onTap: () {
                Navigator.pushNamed(context, "/settings_screen");
              },
            ),
            ProfileMenuItem(
              icon: AppIcons.helpOutline,
              title: 'Help Center',
              onTap: () {
                Navigator.pushNamed(context, "/help_center_screen");
              },
            ),
            ProfileMenuItem(
              icon: AppIcons.lockOutline,
              title: 'Privacy Policy',
              onTap: () {
                Navigator.pushNamed(context, "/privacy_policy_screen");
              },
            ),
            ProfileMenuItem(
              icon: AppIcons.personAddAlt,
              title: 'Invites Friends',
              onTap: () {
                // TODO: Implement invite friends functionality
              },
            ),
            const SizedBox(height: 20), // Bottom spacing
          ],
        ),
      ),
    );
  }
}
