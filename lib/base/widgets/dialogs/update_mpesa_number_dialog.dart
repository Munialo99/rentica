import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class UpdateMpesaNumberDialog extends StatefulWidget {
  final String currentNumber;

  const UpdateMpesaNumberDialog({super.key, required this.currentNumber});

  @override
  State<UpdateMpesaNumberDialog> createState() => _UpdateMpesaNumberDialogState();
}

class _UpdateMpesaNumberDialogState extends State<UpdateMpesaNumberDialog> {
  late TextEditingController _numberController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController(text: widget.currentNumber);
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppStyles.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        'Update M-Pesa Number',
        style: AppStyles.headlineStyle2.copyWith(color: AppStyles.textBlack),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _numberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'e.g., 254712345678',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppStyles.textGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppStyles.primaryColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your M-Pesa number';
            }
            // Basic validation for phone number format (e.g., starts with 2547)
            if (!RegExp(r'^(254|0)\d{9}$').hasMatch(value)) {
              return 'Enter a valid Kenyan phone number (e.g., 2547XXXXXXXX)';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Dismiss dialog
          },
          child: Text(
            'Cancel',
            style: AppStyles.textStyle.copyWith(color: AppStyles.textGrey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              Navigator.pop(context, _numberController.text); // Return new number
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            'Update',
            style: AppStyles.textStyle.copyWith(color: AppStyles.whiteColor),
          ),
        ),
      ],
    );
  }
}