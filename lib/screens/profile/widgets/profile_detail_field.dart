import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class ProfileDetailField extends StatelessWidget {
  final String label;
  final String value;
  final Widget? suffixWidget;
  final bool isSelectable;
  final bool isEditable;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const ProfileDetailField({
    super.key,
    required this.label,
    required this.value,
    this.suffixWidget,
    this.isSelectable = false,
    this.isEditable = false,
    this.controller,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget contentWidget;

    if (isEditable) {
      contentWidget = TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: AppStyles.textStyle.copyWith(
          fontSize: 16,
          color: AppStyles.textBlack,
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
        readOnly: onTap != null,
        onTap: onTap,
      );
    } else {
      contentWidget = Text(
        value,
        style: AppStyles.textStyle.copyWith(
          fontSize: 16,
          color: AppStyles.textBlack,
          fontWeight: FontWeight.w400,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.textStyle.copyWith(
            fontSize: 14,
            color: AppStyles.textGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: isEditable && onTap != null ? onTap : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppStyles.disabledGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: contentWidget,
                ),
                if (suffixWidget != null) ...[
                  const SizedBox(width: 8),
                  suffixWidget!,
                ],
                if (isSelectable && suffixWidget == null)
                  Icon(Icons.keyboard_arrow_down, color: AppStyles.textGrey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}