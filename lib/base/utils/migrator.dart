import 'package:rentica/base/data/mock%20data/user/bookings_data.dart';
import 'package:rentica/main.dart';
import 'package:rentica/services/auth_service.dart';

final _authService = AuthService(supabase);


Future<void> migrateUser() async {
  final userData = {
    'fullName': 'Kababa Kabuda',
    'email': 'kababakabuda13@mail.com',
    'phoneNumber': '+254745745678',
    'profileImageUrl': 'https://img.freepik.com/free-photo/cartoon-style-character-wearing-headphones_23-2151056792.jpg',
    'accountType': 'Premium',
    'memberSince': '2024-03-15',
    'location': 'Kitale, Kenya',
    'bio': 'Lover of cars and adventure and everything in between!',
    'totalTripsCompleted': 15,
    'dob': '1999-03-01',
    'gender': 'Female',
    'mpesaNumber': '254745745678',
  };
  await _authService.signUp(userData['email'] as String, 'secure_password', userData);
  print('User Details migrated');

}

Future<void> migrateBookings() async {
  final locationResponse = await supabase.from('locations').select('id, name');
  final locations = locationResponse as List<dynamic>;
  final user = supabase.auth.currentUser;
  if (user == null) {
    print('No user logged in');
    return;
  }

  // Fetch existing booking IDs
  final existingBookingsResponse = await supabase.from('bookings').select('booking_id');
  if (existingBookingsResponse != null) {
    //print('Error fetching existing bookings: ${existingBookingsResponse!.message}');
    return;
  }
  final existingIds = (existingBookingsResponse as List<dynamic>)
      .map((b) => b['booking_id'] as String)
      .toSet();

  final bookingsData = bookings
      .where((b) => !existingIds.contains(b['bookingId'])) // Skip existing IDs
      .map((b) => {
    'booking_id': b['bookingId'],
    'user_id': user.id,
    'car_id': b['carId'],
    'status': b['status'],
    'start_date': b['startDate'],
    'end_date': b['endDate'],
    'rent_type': b['rent-type'],
    'pick_up_location_id': locations.firstWhere(
          (loc) => loc['name'] == (b['pick-up-location'] == 'Jomo Kenyatta Airport' ? 'JKIA Airport' : b['pick-up-location']),
      orElse: () => throw Exception('Location ${b['pick-up-location']} not found'),
    )['id'],
    'return_location_id': locations.firstWhere(
          (loc) => loc['name'] == (b['return-location'] == 'Karen' ? 'Kilimani' : b['return-location']),
      orElse: () => throw Exception('Location ${b['return-location']} not found'),
    )['id'],
    'mode_of_payment': b['mode-of-payment'],
    'amount': double.parse(b['amount'].toString()),
    'payment_status': b['payment-status'],
  })
      .toList();

  if (bookingsData.isEmpty) {
    print('No new bookings to migrate');
    return;
  }

  final response = await supabase.from('bookings').insert(bookingsData);
  if (response != null) {
    print('Error migrating bookings: ${response!.message}');
  } else {
    print('Bookings migrated successfully: ${bookingsData.length} bookings');
  }
}