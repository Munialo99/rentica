
import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class DriverOptionInfo extends StatelessWidget {
  const DriverOptionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppStyles.whiteColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(
            color: AppStyles.primaryColor,
            width: 4.0,
          ),
        ),
      ),
      child: Text(
        'Additional Kes. 1500/day for Driver Cost if You Choose With Driver Option',
        style: TextStyle(
          color: AppStyles.textDarkGrey,
          fontSize: 12.0,
          height: 1.2, // Line height for better spacing
        ),
      ),
    );
  }
}
