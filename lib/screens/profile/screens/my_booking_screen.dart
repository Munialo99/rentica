import 'package:flutter/material.dart';
import 'package:rentica/base/data/mock%20data/car_rental_list.dart';
import 'package:rentica/base/data/mock%20data/user/bookings_data.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/widgets/cards/car_card_secondary.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Find Car Data by ID
  Map<String, dynamic>? _getCarDataForBooking(String carId) {
    try {
      return carRentalList.firstWhere((car) => car['carId'] == carId);
    } catch (e) {
      print("Error: Car with ID $carId not found in carRentalList. $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        title: Text(
          'My Bookings',
            style: AppStyles.headlineStyle1.copyWith(color: AppStyles.textBlack),
        ),
        centerTitle: true,
        backgroundColor: AppStyles.whiteColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppStyles.primaryColor,
          labelColor: AppStyles.primaryColor,
          unselectedLabelColor: AppStyles.textGrey,
          labelStyle: AppStyles.textStyle.copyWith(fontWeight: FontWeight.bold),
          unselectedLabelStyle:
          AppStyles.textStyle.copyWith(fontWeight: FontWeight.normal),
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsContent(upcomingBookings, 'upcoming'),
          _buildBookingsContent(completedBookings, 'completed'),
          _buildBookingsContent(cancelledBookings, 'cancelled'),
        ],
      ),
    );
  }

  // Builder for all lists
  Widget _buildBookingsContent(List<Map<String, dynamic>> bookingList, String status) {
    if (bookingList.isEmpty) {
      return Center(
        child: Text(
          'Nothing to see here👋🏾.',
          style: AppStyles.textStyle.copyWith(color: AppStyles.textGrey),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          children: bookingList.map((booking) {
            final String carId = booking['carId'];
            final Map<String, dynamic>? carData = _getCarDataForBooking(carId);

            if (carData == null) {
              return const SizedBox.shrink();
            }

            final Map<String, dynamic> combinedData = {
              ...carData, // Spread car details
              ...booking, // Spread booking details (bookingId, status, dates)
            };

            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/car_detail_screen', arguments: combinedData);
                },
                child: CarCardSecondary(
                  carData: combinedData,
                  isFullWidth: true,
                  bookingStatus: status,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}