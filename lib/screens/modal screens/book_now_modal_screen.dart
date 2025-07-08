import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/widgets/cards/book_now_card.dart';
import 'package:rentica/base/widgets/buttons/bottom_nav_btn.dart';
import 'package:rentica/providers/booking_provider.dart';

class BookNowModalScreen extends ConsumerWidget {
  final Map<String, dynamic> carData;
  const BookNowModalScreen({super.key, required this.carData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppStyles.bgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Pull bar
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // App Bar substitute
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios_new,
                          color: AppStyles.textBlack),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Book Now",
                      style: TextStyle(
                        color: AppStyles.textBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Body
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  children: [
                    BookNowCard(
                      carData: carData,
                    ),
                  ],
                ),
              ),

              // Bottom Button
              GestureDetector(
                  onTap: () {
                    final bookingState = ref.watch(bookingProvider(carData));

                    final bookingData = {
                      'carData': bookingState.carData,
                      'rentType': bookingState.rentType,
                      'pickUpDate': bookingState.pickUpDate,
                      'pickUpLocation': bookingState.pickUpLocation,
                      'returnDate': bookingState.returnDate,
                      'returnLocation': bookingState.returnLocation,
                    };

                    Navigator.pushNamed(context, '/booking_summary_screen',
                        arguments: bookingData);
                  },
                  child: BottomNavBtn(showPrice: false, labelText: "Continue")),
            ],
          ),
        );
      },
    );
  }
}
