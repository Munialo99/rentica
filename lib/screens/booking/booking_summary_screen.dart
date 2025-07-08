import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/widgets/buttons/bottom_nav_btn.dart';
import 'package:rentica/base/widgets/cards/vehicle_summary_card.dart';
import 'package:rentica/base/widgets/dialogs/phone_change_dialog.dart';
import 'package:rentica/providers/booking_provider.dart';

class BookingSummaryScreen extends ConsumerWidget  {
  final Map<String, dynamic> bookingData;
  const BookingSummaryScreen(this.bookingData, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider(bookingData['carData'] as Map<String, dynamic>));

    final carData = bookingState.carData;
    final rentType = bookingState.rentType;
    final pickUpDate = bookingState.pickUpDate;
    final pickUpLocation = bookingState.pickUpLocation;
    final returnDate = bookingState.returnDate;
    final returnLocation = bookingState.returnLocation;
    final numberOfDays = bookingState.numberOfDays;
    final totalRentalAmount = bookingState.totalRentalAmount;

    //format date and time
    String formatDateTime(DateTime? dt) {
      if (dt == null) return 'Not selected';
      return DateFormat('E, d MMM yy | hh:mm a').format(dt);
    }

    TextStyle labelStyle = const TextStyle(fontSize: 14, color: Colors.black87);
    TextStyle valueStyle =
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    TextStyle totalStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return Scaffold(
      bottomNavigationBar:
          BottomNavBtn(showPrice: false, labelText: "Checkout"),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Booking Summary',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //Vehicle Details
            VehicleSummaryCard(
              carData: carData,
            ),
            SizedBox(
              height: 10,
            ),
            // Information Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _row("Pick-Up Date & Time", formatDateTime(pickUpDate),
                      labelStyle, valueStyle),
                  const SizedBox(height: 10),
                  _row("Pick-Up Location", pickUpLocation ?? "Main Office",
                      labelStyle, valueStyle),
                  const SizedBox(height: 10),
                  _row("Return Date & Time", formatDateTime(returnDate),
                      labelStyle, valueStyle),
                  const SizedBox(height: 10),
                  _row("Return Location", returnLocation ?? "Main Office",
                      labelStyle, valueStyle),
                  const SizedBox(height: 10),
                  _row("Rent Type", rentType ?? "Self-Drive", labelStyle,
                      valueStyle),
                  const Divider(height: 30),
                  _row("Rate/Day", "KES. ${carData['rentalPrice']}", labelStyle, valueStyle),
                  const SizedBox(height: 10),
                  _row("No. of Days", "$numberOfDays", labelStyle, valueStyle),
                 // const SizedBox(height: 10),
                 // _row("Fees", "\$50.00", labelStyle, valueStyle),
                  const Divider(height: 30),

                  _row("Total", "$totalRentalAmount", labelStyle, totalStyle),
                  const SizedBox(height: 24),

                  // Payment Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            'https://i.pinimg.com/736x/ef/62/3c/ef623caaf9e27d3cc25080d6ef1c3edf.jpg',
                            //width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text('07000***',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => PhoneChangeDialog(
                              currentPhone: "+254712345678",
                              onSubmit: (newPhone) {
                                print("Updated phone: $newPhone");
                                // Save or update state here
                                // TODO: Implementation change phone number
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Change',
                          style: AppStyles.textStyle4.copyWith(
                              color: AppStyles.primaryColor,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
      String label, String value, TextStyle labelStyle, TextStyle valueStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: valueStyle,
          ),
        ),
      ],
    );
  }
}
