List<Map<String, dynamic>> bookings = [
  {
    'bookingId': 'B001',
    'carId': 'CR001',
    'status': 'upcoming',
    'startDate': '2025-07-10',
    'endDate': '2025-07-13',
  },
  {
    'bookingId': 'B002',
    'carId': 'CR003',
    'status': 'completed',
    'startDate': '2025-06-25',
    'endDate': '2025-06-28',
  },
  {
    'bookingId': 'B003',
    'carId': 'CR005',
    'status': 'cancelled',
    'startDate': '2025-07-01',
    'endDate': '2025-07-03',
  },
];

List<Map<String, dynamic>> upcomingBookings = bookings.where((b) => b['status'] == 'upcoming').toList();
List<Map<String, dynamic>> completedBookings = bookings.where((b) => b['status'] == 'completed').toList();
List<Map<String, dynamic>> cancelledBookings = bookings.where((b) => b['status'] == 'cancelled').toList();

