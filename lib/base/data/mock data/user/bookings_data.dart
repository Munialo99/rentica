List<Map<String, dynamic>> bookings = [
  {
    'bookingId': 'B001',
    'carId': 'CR001',
    'status': 'upcoming',
    'startDate': '2025-07-10',
    'endDate': '2025-07-13',
    'rent-type': 'Chauffeur',
    'pick-up-location': 'Jomo Kenyatta Airport',
    'return-location': 'Karen',
    'mode-of-payment': 'card',
    'amount': '13500',
    'payment-status': 'pending',
  },
  {
    'bookingId': 'B002',
    'carId': 'CR003',
    'status': 'completed',
    'startDate': '2025-06-25',
    'endDate': '2025-06-28',
    'rent-type': 'Self-Drive',
    'pick-up-location': 'Nairobi CBD',
    'return-location': 'Westlands',
    'mode-of-payment': 'mpesa',
    'amount': '9000',
    'payment-status': 'paid',
  },
  {
    'bookingId': 'B003',
    'carId': 'CR005',
    'status': 'cancelled',
    'startDate': '2025-07-01',
    'endDate': '2025-07-03',
    'rent-type': 'Self-Drive',
    'pick-up-location': 'Westlands',
    'return-location': 'Thika Road',
    'mode-of-payment': 'cash',
    'amount': '0',
    'payment-status': 'cancelled',
  },
];


List<Map<String, dynamic>> upcomingBookings = bookings.where((b) => b['status'] == 'upcoming').toList();
List<Map<String, dynamic>> completedBookings = bookings.where((b) => b['status'] == 'completed').toList();
List<Map<String, dynamic>> cancelledBookings = bookings.where((b) => b['status'] == 'cancelled').toList();

