// base/widgets/cards/car_card_secondary.dart
import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/utils/car_icon_mapper.dart';
import 'package:rentica/base/widgets/buttons/favorite_btn.dart';
import 'package:rentica/screens/modal%20screens/book_now_modal_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentica/screens/modal%20screens/cancel_ride_modal_screen.dart';

import 'vehicle_type_color_card.dart';

class CarCardSecondary extends StatelessWidget {
  final Map<String, dynamic> carData;
  final bool isFullWidth;
  final String? bookingStatus;

  const CarCardSecondary({
    super.key,
    this.isFullWidth = false,
    required this.carData,
    this.bookingStatus,
  });

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    // Extract Car Data
    final String carId = carData['carId'] ?? '';
    final String carName = carData['carName'] ?? '';
    final String carModel = carData['carModel'] ?? '';
    final int rentalPrice = carData['rentalPrice'];
    final String carType = carData['carType'];
    final List<Map<String, dynamic>> gallery =
    (carData['gallery'] as List<dynamic>).cast<Map<String, dynamic>>();

    // Get thumbnail image
    final Map<String, dynamic> thumbnailImage = gallery.firstWhere(
          (img) => img['isThumbnail'] == true,
      orElse: () => gallery.first,
    );

    final String thumbnailUrl = thumbnailImage['url'];

    // Determine if it's a booking card (i.e., bookingStatus is provided)
    bool isBookingCard = bookingStatus != null;

    // Get booking dates if available
    final String? startDate = carData['startDate'];
    final String? endDate = carData['endDate'];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/car_detail_screen', arguments: carData);
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        width: isFullWidth ? deviceWidth : deviceWidth * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
                child: Image.network(
                  thumbnailUrl.trim(),
                  height: 150,
                  width: isFullWidth ? deviceWidth : deviceWidth * 0.75,
                  fit: BoxFit.cover,
                ),
              ),
              // Favorite button only for non-booking cards
              if (!isBookingCard)
                Positioned(
                  top: 10,
                  right: 10,
                  child: FavoriteBtn(
                    id: carId,
                    onChanged: (isFavorited) {
                      // Todo: Implementation
                      if (isFavorited) {
                        print('Added to favorites');
                      } else {
                        print('Removed from favorites');
                      }
                    },
                  ),
                ),
            ]),
            // Product Details
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name
                      Text(
                        carName,
                        style: AppStyles.headlineStyle3
                            .copyWith(color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Car Model row
                      Row(
                        children: [
                          SvgPicture.asset(getCarModelIcon(carModel),
                              height: 14,
                              colorFilter: ColorFilter.mode(
                                  AppStyles.textGrey, BlendMode.srcIn)),
                          const SizedBox(width: 4),
                          Text(
                            carModel,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppStyles.textGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Display booking dates if it's a booking card
                      if (isBookingCard && startDate != null && endDate != null)
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 14, color: AppStyles.textGrey),
                            const SizedBox(width: 4),
                            Text(
                              '$startDate to $endDate',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppStyles.textGrey,
                              ),
                            ),
                          ],
                        )
                      else if (!isBookingCard) // Show rating for general car cards
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.numberPlate2,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                    AppStyles.textGrey, BlendMode.srcIn)),
                            const SizedBox(width: 4),
                            Text(
                              "4.9 (30 Trips)", // Static for now, consider making this dynamic
                              style: TextStyle(
                                fontSize: 14,
                                color: AppStyles.textGrey,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  // Pricing/day, Type of Car
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "KES. ${rentalPrice.toStringAsFixed(0)}",
                        style: AppStyles.headlineStyle3
                            .copyWith(color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "/day",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppStyles.textGrey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Vehicle Type
                      VehicleTypeColorCard(label: carType),
                    ],
                  ),
                ],
              ),
            ),
            // Action Buttons based on booking status
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: _buildActionButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
    IconData? icon,
    Color textColor = Colors.white,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: AppStyles.textStyle.copyWith(color: textColor, fontSize: 14),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, color: textColor, size: 14),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    switch (bookingStatus) {
      case 'upcoming':
        return Row(
          children: [
            _buildActionButton(
              text: 'Cancel',
              color: Colors.red,
              onPressed: () async {
                final result = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => CancelRideModalScreen(
                    bookingId: carData['bookingId'],
                    carName: carData['carName'],
                  ),
                );

                if (result != null) {
                  print('Cancellation confirmed with reason: $result');
                  // Todo: Implement actual cancellation logic here,
                } else {
                  print('Cancellation modal dismissed without confirmation.');
                }
              },
            ),
            const SizedBox(width: 10), // Space between buttons
            _buildActionButton(
              text: 'Reschedule',
              color: Colors.green,
              onPressed: () {
                // Todo: Implement reschedule logic
                print('Reschedule booking: ${carData['bookingId']}');
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => BookNowModalScreen(
                    carData: carData, // Pass relevant data for rescheduling
                  ),
                );
              },
            ),
          ],
        );
      case 'completed':
        return _buildActionButton(
          text: 'Rebook Ride',
          color: AppStyles.primaryColor,
          onPressed: () {
            // Todo: Implement rebook logic
            print('Rebook ride: ${carData['bookingId']}');
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => BookNowModalScreen(
                carData: carData, // Pass carData for booking process
              ),
            );
          },
          icon: Icons.arrow_forward_ios_rounded,
        );
      case 'cancelled':
        return _buildActionButton(
          text: 'Book Again',
          color: AppStyles.primaryColor, // Use a suitable color
          onPressed: () {
            // Todo: Implement book again logic
            print('Book again: ${carData['carId']}');
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => BookNowModalScreen(
                carData: carData, // Pass carData for booking process
              ),
            );
          },
          icon: Icons.arrow_forward_ios_rounded,
        );
      default:
      // Default "Book Now" button for general car listings (not booking specific)
        return _buildActionButton(
          text: 'Book Now',
          color: AppStyles.primaryColor,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => BookNowModalScreen(
                carData: carData,
              ),
            );
          },
          icon: Icons.arrow_forward_ios_rounded,
        );
    }
  }
}