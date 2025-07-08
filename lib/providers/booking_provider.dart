import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/utils/date_calculation.dart';


class BookingState {
  final Map<String, dynamic> carData;
  final String? rentType;
  final DateTime? pickUpDate;
  final String? pickUpLocation;
  final DateTime? returnDate;
  final String? returnLocation;
  final int? numberOfDays;
  final double? totalRentalAmount;

  BookingState({
    required this.carData,
    this.rentType,
    this.pickUpDate,
    this.pickUpLocation,
    this.returnDate,
    this.returnLocation,
    this.numberOfDays,
    this.totalRentalAmount,
  });

  BookingState copyWith({
    String? rentType,
    DateTime? pickUpDate,
    String? pickUpLocation,
    DateTime? returnDate,
    String? returnLocation,
    int? numberOfDays,
    double? totalRentalAmount,

    Map<String, dynamic>? carData,
  }) {
    return BookingState(
      // Ensure carData is preserved if not explicitly updated
      carData: carData ?? this.carData,
      rentType: rentType ?? this.rentType,
      pickUpDate: pickUpDate ?? this.pickUpDate,
      pickUpLocation: pickUpLocation ?? this.pickUpLocation,
      returnDate: returnDate ?? this.returnDate,
      returnLocation: returnLocation ?? this.returnLocation,
      numberOfDays: numberOfDays ?? this.numberOfDays,
      totalRentalAmount: totalRentalAmount ?? this.totalRentalAmount,
    );
  }

  // Optional: Add a toString method for easier debugging
  @override
  String toString() {
    return 'BookingState(\n'
        '  carData: $carData,\n'
        '  rentType: $rentType,\n'
        '  pickUpDate: $pickUpDate,\n'
        '  pickUpLocation: $pickUpLocation,\n'
        '  returnDate: $returnDate,\n'
        '  returnLocation: $returnLocation\n'
        '  numberOfDays: $numberOfDays,\n'
        '  totalRentalAmount: $totalRentalAmount\n'
        ')';
  }
}

class BookingNotifier extends StateNotifier<BookingState> {
  final int _rentalPricePerDay; // Store the rental price for calc

  BookingNotifier(Map<String, dynamic> initialCarData)
  // Extract rentalPrice from initialCarData once
      : _rentalPricePerDay = initialCarData['rentalPrice'] as int,
        super(_buildInitialState(initialCarData));

  // helper to build the initial state, including initial calc
  static BookingState _buildInitialState(Map<String, dynamic> carData) {
    final int initialRentalPrice = carData['rentalPrice'] as int;

    // Initial calc (dates are null initially, so days and amount will be 0)
    final int initialNumberOfDays = BookingCalculator.calculateRentalDays(null, null);
    final double initialTotalRentalAmount = (initialNumberOfDays * initialRentalPrice).toDouble();

    return BookingState(
      carData: carData,
      rentType: 'Self-Drive', // Set initial default
      numberOfDays: initialNumberOfDays,
      totalRentalAmount: initialTotalRentalAmount,
    );
  }

  // re-calculate days and total amount based on current state
  void _recalculateTotals() {
    final int calculatedDays = BookingCalculator.calculateRentalDays(
      state.pickUpDate,
      state.returnDate,
    );
    final double calculatedTotal = (calculatedDays * _rentalPricePerDay).toDouble();

    state = state.copyWith(
      numberOfDays: calculatedDays,
      totalRentalAmount: calculatedTotal,
    );
  }

  void updateRentType(String? rentType) {
    state = state.copyWith(rentType: rentType);
    // Recalculate if rent type affects price (e.g., if "with driver" adds cost)
    // For now, it only changes _recalculateTotals if rentalPricePerDay varied by rentType
    // which it currently does not. If it did, you'd update _rentalPricePerDay here too.
    _recalculateTotals(); // Re-trigger calculation as a safe measure.
  }

  void updatePickUpDate(DateTime? date) {
    state = state.copyWith(pickUpDate: date);
    _recalculateTotals(); // Recalculate when pick-up date changes
  }

  void updatePickUpLocation(String? location) {
    state = state.copyWith(pickUpLocation: location);
  }

  void updateReturnDate(DateTime? date) {
    state = state.copyWith(returnDate: date);
    _recalculateTotals(); // Recalculate when return date changes
  }

  void updateReturnLocation(String? location) {
    state = state.copyWith(returnLocation: location);
  }

  // Optional: A method to clear all booking-specific details
  void clearBookingDatesAndLocations() {
    state = state.copyWith(
      pickUpDate: null,
      pickUpLocation: null,
      returnDate: null,
      returnLocation: null,
      numberOfDays: 0, // Reset calculated values
      totalRentalAmount: 0.0, // Reset calculated values
    );
  }
}

final bookingProvider =
StateNotifierProvider.autoDispose.family<BookingNotifier, BookingState, Map<String, dynamic>>(
      (ref, carData) {
    return BookingNotifier(carData);
  },
  name: 'bookingProvider',
);