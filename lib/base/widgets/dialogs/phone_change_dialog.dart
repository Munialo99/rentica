import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class PhoneChangeDialog extends StatelessWidget {
  final String currentPhone;
  final void Function(String) onSubmit;

  const PhoneChangeDialog({
    super.key,
    required this.currentPhone,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: currentPhone);

    return AlertDialog(
      backgroundColor: AppStyles.bgColor,
      title: Text('Edit Payment Phone Number', style: AppStyles.headlineStyle3,),
      content: TextField(
        cursorColor: AppStyles.primaryColor,
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: AppStyles.primaryColor),
          labelText: 'Phone Number',
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyles.primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancel
          child: Text('Cancel', style: TextStyle(color: AppStyles.textGrey),),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.primaryColor,
          ),
          onPressed: () {
            onSubmit(controller.text.trim());
            Navigator.pop(context);
          },
          child: Text('Submit', style: TextStyle(color: AppStyles.whiteColor),),
        ),
      ],
    );
  }
}
