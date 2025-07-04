import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class CarSearchBar extends StatelessWidget {
  const CarSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            "Search for cars, cities, etc.",
            style: AppStyles.textStyle2,
          ),
        ],
      ),
    );
  }
}
