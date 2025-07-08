import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/providers/booking_provider.dart';

class PaymentSummaryCard extends ConsumerWidget {
  final Map<String, dynamic> carData;

  const PaymentSummaryCard({
    super.key,
    required this.carData,
  });

  // Define your tax rate here (e.g., 16% VAT for Kenya)
  //static const double _taxRate = 0.16;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider(carData));

    final double rentDay =
        (bookingState.carData['rentalPrice'] as int).toDouble();
    final int days = bookingState.numberOfDays ?? 0;
    final double totalAmount = bookingState.totalRentalAmount ?? 0.0;

    /*final double subtotalBeforeTax = totalAmount / (1 + _taxRate);
    final double taxAmount = totalAmount - subtotalBeforeTax;*/

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppStyles.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rent/Day
          _buildRow("Rent/Day", rentDay,
              isCurrency: true), // Indicate it's a currency value
          const SizedBox(height: 6),

          // Number of Days
          _buildRow("Number of Days", days.toDouble(), isCurrency: false),
          /*const SizedBox(height: 6),
          // Subtotal (before tax) - NEW ROW
          _buildRow("Subtotal + Discount", subtotalBeforeTax, isCurrency: true),
          const SizedBox(height: 6),

          // Tax - NEW ROW
          _buildRow("Tax (${(_taxRate * 100).toStringAsFixed(0)}%)", taxAmount, isCurrency: true),
          const SizedBox(height: 10), // Spacing before the total divider*/

          const Divider(height: 30),
          // Total
          _buildRow("Total", totalAmount,
              isBold: true, isCurrency: true), // Total is bold and currency
          const Divider(height: 30),

          // Payment Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Available Payment Method",
                style: AppStyles.textStyle.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppStyles.textGrey,
                ),
              ),
              _buildPaymentIcon(
                  'https://i.pinimg.com/736x/ef/62/3c/ef623caaf9e27d3cc25080d6ef1c3edf.jpg'), //MPESA LOGO
            ],
          )
        ],
      ),
    );
  }

  // Modified _buildRow: now directly formats the value
  Widget _buildRow(String label, double value,
      {bool isBold = false, bool isCurrency = false}) {
    final String formattedValue = isCurrency
        ? "KES ${value.toStringAsFixed(2)}"
        : value.toInt().toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.textStyle.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          formattedValue,
          style: AppStyles.textStyle.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentIcon(String url) {
    return Image.network(
      url,
      height: 24,
      fit: BoxFit.contain,
    );
  }
}
