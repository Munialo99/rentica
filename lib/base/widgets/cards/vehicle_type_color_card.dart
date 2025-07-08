import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/res/vehicle_type_style.dart';

class VehicleTypeColorCard extends StatelessWidget {
  final String label;
  const VehicleTypeColorCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: VehicleTypeStyles.getColor(label),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
