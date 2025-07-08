import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/data/mock%20data/booking_locations_data.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/providers/booking_provider.dart';
import 'package:rentica/base/utils/enums.dart';

class LocationSelector extends ConsumerWidget {
  final String labelText;
  final LocationType type;
  final Map<String, dynamic> carData;

  const LocationSelector({
    super.key,
    required this.labelText,
    required this.type,
    required this.carData,
  });

  void _openLocationPicker(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kLocations.length,
        itemBuilder: (context, index) {
          final location = kLocations[index];
          return ListTile(
            title: Text(location),
            onTap: () => Navigator.pop(context, location),
          );
        },
      ),
    );

    if (result != null) {
      // Update the correct state in the Riverpod provider
      final notifier = ref.read(bookingProvider(carData).notifier);
      if (type == LocationType.pickup) {
        notifier.updatePickUpLocation(result);
      } else {
        notifier.updateReturnLocation(result);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to get the current location
    final bookingState = ref.watch(bookingProvider(carData));
    final selectedLocation = type == LocationType.pickup
        ? bookingState.pickUpLocation
        : bookingState.returnLocation;

    return GestureDetector(
      onTap: () => _openLocationPicker(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppStyles.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on, color: AppStyles.primaryColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedLocation ?? labelText,
                style: AppStyles.textStyle.copyWith(
                  color: selectedLocation == null
                      ? AppStyles.textGrey
                      : AppStyles.textDarkGrey,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
