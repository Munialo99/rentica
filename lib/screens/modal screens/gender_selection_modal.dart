import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class GenderSelectionModal extends StatelessWidget {
  final String? currentGender;

  const GenderSelectionModal({super.key, this.currentGender});

  @override
  Widget build(BuildContext context) {
    final List<String> genders = ['Male', 'Female'];

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppStyles.whiteColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select Gender',
              style: AppStyles.headlineStyle2.copyWith(color: AppStyles.textBlack),
            ),
            const SizedBox(height: 15),
            ...genders.map((genderOption) {
              return ListTile(
                title: Text(genderOption, style: AppStyles.textStyle4),
                trailing: currentGender == genderOption
                    ? Icon(Icons.check, color: AppStyles.primaryColor)
                    : null,
                onTap: () {
                  Navigator.pop(context, genderOption); // Return selected gender
                },
              );
            }).toList(),
//            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}