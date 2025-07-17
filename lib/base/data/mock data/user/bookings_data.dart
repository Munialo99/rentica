List<Map<String, dynamic>> bookings = [
  {
    'bookingId': 'B005',
    'carId': 'CR001',
    'status': 'upcoming',
    'startDate': '2025-02-10',
    'endDate': '2025-02-13',
    'rent-type': 'Chauffeur',
    'pick-up-location': 'JKIA Airport',
    'return-location': 'Kilimani',
    'mode-of-payment': 'mpesa',
    'amount': '13500',
    'payment-status': 'pending',
  },
  {
    'bookingId': 'B006',
    'carId': 'CR003',
    'status': 'completed',
    'startDate': '2025-03-25',
    'endDate': '2025-03-28',
    'rent-type': 'Self-Drive',
    'pick-up-location': 'Nairobi CBD',
    'return-location': 'Westlands',
    'mode-of-payment': 'mpesa',
    'amount': '9000',
    'payment-status': 'paid',
  },
  {
    'bookingId': 'B007',
    'carId': 'CR005',
    'status': 'cancelled',
    'startDate': '2025-04-01',
    'endDate': '2025-04-03',
    'rent-type': 'Self-Drive',
    'pick-up-location': 'Westlands',
    'return-location': 'Thika Road Mall',
    'mode-of-payment': 'cash',
    'amount': '0',
    'payment-status': 'cancelled',
  },
];


List<Map<String, dynamic>> upcomingBookings = bookings.where((b) => b['status'] == 'upcoming').toList();
List<Map<String, dynamic>> completedBookings = bookings.where((b) => b['status'] == 'completed').toList();
List<Map<String, dynamic>> cancelledBookings = bookings.where((b) => b['status'] == 'cancelled').toList();

