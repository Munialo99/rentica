import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class DoubleHeaderButton extends StatelessWidget {
  const DoubleHeaderButton(
      {super.key, required this.bigText, required this.smallText, required this.func, this.isVisible = true, this.tinyText, this.tinyTextVisible = false});
  final String bigText;
  final String smallText;
  final String? tinyText;
  final VoidCallback? func;
  final bool? isVisible;
  final bool? tinyTextVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(bigText, style: AppStyles.headlineStyle2.copyWith(color: Colors.black)),
            if(tinyTextVisible ?? true)
              Text(
                tinyText!,
                style: AppStyles.textStyle2.copyWith(fontSize: 10, color: AppStyles.textGrey, fontWeight: FontWeight.w500),
              ),
          ],
        ),

        if(isVisible ?? true)
          InkWell(
            onTap: func,
            child: Text(
              smallText,
              style: AppStyles.textStyle2.copyWith(color: AppStyles.primaryColor, fontWeight: FontWeight.w500),
            ),
          ),

      ],
    );
  }
}
