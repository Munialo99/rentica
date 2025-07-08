import 'package:flutter/material.dart';

class AccountBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final double iconSize;
  final double fontSize;
  final Color backgroundColor;
  final Color iconAndTextColor;

  const AccountBadge({
    super.key,
    this.label = 'User Account',
    this.icon = Icons.shield,
    this.iconSize = 16,
    this.fontSize = 12,
    required this.backgroundColor,
    required this.iconAndTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconAndTextColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: iconAndTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
