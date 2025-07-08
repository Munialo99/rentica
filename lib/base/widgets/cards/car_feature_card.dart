import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentica/base/res/app_styles.dart';

class CarFeatureCard extends StatelessWidget {
  final String svgIcon;
  final String label;
  final String value;

  const CarFeatureCard({
    super.key,
    required this.svgIcon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 3 - 24,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: AppStyles.whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(svgIcon,
                height: 28,
                colorFilter: ColorFilter.mode(AppStyles.primaryColor, BlendMode.srcIn)
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: AppStyles.textStyle2.copyWith(fontSize: 12),
            ),
            SizedBox(height: 4),
            Text(
                value,
                style: AppStyles.headlineStyle3
            ),
          ],
        ),
      ),
    );
  }
}