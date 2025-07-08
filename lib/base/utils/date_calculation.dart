import 'package:intl/intl.dart';

class BookingCalculator {
  /// Calculates the number of days between two nullable DateTimes.
  /// Rounds up to the nearest day if there's a partial day.
  /// Returns 0 if either date is null, or if returnDate is before pickUpDate.
  static int calculateRentalDays(DateTime? pickUpDate, DateTime? returnDate) {
    if (pickUpDate == null || returnDate == null) {
      return 0; // Cannot calculate if dates are missing
    }

    // Ensure pickUpDate is before returnDate for valid calculation
    if (returnDate.isBefore(pickUpDate)) {
      return 0; // Invalid date range
    }

    // Calculate the difference in hours
    final Duration duration = returnDate.difference(pickUpDate);
    final double totalHours = duration.inMinutes / 60.0; // Use minutes for higher precision

    // Round up to the nearest full day
    // A rental of 1 hour should count as 1 day for daily rates
    // A rental of 24 hours should count as 1 day
    // A rental of 25 hours should count as 2 days
    if (totalHours <= 0) {
      return 0; // Handles cases where duration is zero or negative
    }

    final double totalDays = totalHours / 24.0;

    return totalDays.ceil(); // round up to the nearest whole number
  }

  /// Formats a nullable DateTime for display.
  static String formatDateTime(DateTime? dt) {
    if (dt == null) return 'Not selected';
    return DateFormat('E, d MMM, hh:mm a').format(dt);
  }
}