import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/utils/enums.dart';
import 'package:rentica/base/widgets/cards/vehicle_summary_card.dart';
import 'package:rentica/base/widgets/date_time_selector.dart';
import 'package:rentica/base/widgets/cards/driver_option_info.dart';
import 'package:rentica/base/widgets/location_selector.dart';
import 'package:rentica/base/widgets/cards/payment_summary_card.dart';
import 'package:rentica/providers/booking_provider.dart';

class BookNowCard extends ConsumerWidget {
  final Map<String, dynamic> carData;
  const BookNowCard({super.key, required this.carData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // final int rentalPrice = carData['rentalPrice'];
    //watch booking state to get latest calcs
    final bookingState = ref.watch(bookingProvider(carData));
    final bookingNotifier = ref.read(bookingProvider(carData).notifier);

    // Access the calculated totalRentalAmount directly from the state
    final double totalRentalAmount = bookingState.totalRentalAmount ?? 0.0;
// Todo: Display bookingState.numberOfDays


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VehicleSummaryCard(
          carData: carData,
        ),
        SizedBox(
          height: 5,
        ),
        // RENT TYPE
        Divider(),
        SizedBox(
          height: 5,
        ),
        Text("Rent Type",
            style: AppStyles.headlineStyle2.copyWith(color: Colors.black)),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => bookingNotifier.updateRentType('Self-Drive'),
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ref.watch(bookingProvider(carData)).rentType ==
                            'Self-Drive'
                        ? AppStyles.primaryColor
                        : AppStyles.disabledGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Self-Drive',
                    style: AppStyles.textStyle.copyWith(
                        color: ref.watch(bookingProvider(carData)).rentType ==
                                'Self-Drive'
                            ? AppStyles.whiteColor
                            : AppStyles.textBlack),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12), // spacing between
            Expanded(
              child: GestureDetector(
                onTap: () => bookingNotifier.updateRentType('With Driver'),
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ref.watch(bookingProvider(carData)).rentType == 'With Driver'
                        ? AppStyles.primaryColor
                        : AppStyles.disabledGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'With Driver',
                    style:
                        AppStyles.textStyle.copyWith(color: ref.watch(bookingProvider(carData)).rentType == 'With Driver'
                            ? AppStyles.whiteColor
                            : AppStyles.textBlack),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        // DRIVER OPTION COST
        DriverOptionInfo(),
        SizedBox(
          height: 10,
        ),
        Divider(),
        //PICK UP DATE & TIME
        SizedBox(
          height: 10,
        ),
        Text("Pick-Up Date & Time",
            style: AppStyles.headlineStyle2.copyWith(color: Colors.black)),
        SizedBox(
          height: 10,
        ),
        DateTimeSelector(
          type: DateType.pickup,
          carData: carData,
        ),
        SizedBox(
          height: 10,
        ),
        LocationSelector(
          labelText: "Pick-Up Location",
          type: LocationType.pickup,
          carData: carData,
        ),
        // RETURN DATE & TIME
        SizedBox(
          height: 20,
        ),
        Text("Return Date & Time",
            style: AppStyles.headlineStyle2.copyWith(color: Colors.black)),
        SizedBox(
          height: 10,
        ),
        DateTimeSelector(
          type: DateType.returnDate,
          carData: carData,
        ),
        SizedBox(
          height: 10,
        ),
        LocationSelector(
          labelText: "Return Location",
          type: LocationType.returnLocation,
          carData: carData,
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        //Payment Summary
        SizedBox(
          height: 10,
        ),
        Text("Payment Summary",
            style: AppStyles.headlineStyle2.copyWith(color: Colors.black)),
        SizedBox(
          height: 10,
        ),
        PaymentSummaryCard(carData: carData,),
      ],
    );
  }
}
