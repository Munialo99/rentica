import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/screens/modal%20screens/book_now_modal_screen.dart';

class BottomNavBtn extends StatelessWidget {
  final bool showPrice;
  final String? priceText;
  final String labelText;
  const BottomNavBtn(
      {super.key,
      this.showPrice = true,
      required this.labelText,
      this.priceText});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppStyles.whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showPrice) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'KES',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppStyles.textBlack, fontWeight: FontWeight.w500
                    ),
                  ),
                  //SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: priceText,
                          style:
                              AppStyles.headlineStyle1.copyWith(fontSize: 22),
                        ),
                        TextSpan(
                          text: '/day',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppStyles.primaryColor, fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              _bookButton(width: 200),
            ] else
              Expanded(child: _bookButton(width: double.infinity)),
          ],
        ),
      ),
    );
  }

  Widget _bookButton({required double width}) {
    return Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppStyles.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            labelText,
            style: AppStyles.textStyle.copyWith(color: AppStyles.whiteColor),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios_rounded,
              color: Colors.white, size: 16),
        ],
      ),
    );
  }
}
