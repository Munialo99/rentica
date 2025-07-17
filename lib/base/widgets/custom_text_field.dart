import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

Widget buildCustomTextField({
  required String hintText,
  required IconData icon,
  required TextEditingController controller,
  bool isPassword = false,
  bool obscureText = false,
  VoidCallback? onSuffixIconTap,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: AppStyles.whiteColor,
      prefixIcon: Icon(icon, color: Colors.grey),
      suffixIcon: isPassword
          ? GestureDetector(
        onTap: onSuffixIconTap,
        child: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
      )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.white, width: 0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: AppStyles.primaryColor, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    ),
  );
}