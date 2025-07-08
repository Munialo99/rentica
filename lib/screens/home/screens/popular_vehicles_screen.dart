import 'package:flutter/material.dart';
import 'package:rentica/base/data/mock%20data/car_rental_list.dart' show carRentalList, favoriteCars, trendingCars, popularCars;
import 'package:rentica/base/data/vehicle_types_data.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/widgets/cards/car_card_primary.dart';
import 'package:rentica/base/widgets/cards/car_card_secondary.dart';
import 'package:rentica/base/widgets/double_header_btn.dart';
import 'package:rentica/base/widgets/my_app_bar.dart';
import 'package:rentica/base/widgets/cards/vehicle_type.dart';

import '../../../base/data/mock data/car_rental_list.dart' show carRentalList, favoriteCars;

class PopularVehiclesScreen extends StatelessWidget {
  const PopularVehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UniqueVehicleType> vehicleTypes = getUniqueVehicleTypes();

    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: CustomScrollView(
        slivers: [
          MyAppBar(
            leadingWidget: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: AppStyles.whiteColor),
            ),
            actionWidget: IconButton(
              onPressed: () {
                //Todo: Implement menu button
              },
              icon: Icon(Icons.menu_rounded, color: AppStyles.whiteColor),
            ),
            title: "Popular Vehicles",
            centerSection: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Find the best car rental\ndeals on Kabuda!",
                      style: AppStyles.headlineStyle1.copyWith(
                        color: AppStyles.whiteColor,
                        fontSize: 27,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            lowerSection: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Incredible Deals, Special Offers &\nDiscount up to 30%",
                  textAlign: TextAlign.center,
                  style: AppStyles.headlineStyle2.copyWith(
                      color: AppStyles.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    // Trending Vehicles
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: popularCars.map((singleCar) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/car_detail_screen', arguments: singleCar);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: CarCardSecondary(
                                carData: singleCar,
                                isFullWidth: true,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    //  Vehicles Type
                    SizedBox(
                      height: 20,
                    ),
                    DoubleHeaderButton(
                      bigText: 'Vehicle Type',
                      smallText: 'View All',
                      tinyTextVisible: true,
                      isVisible: false,
                      tinyText: 'Find What You Want',
                      func: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Vehicle Types
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: vehicleTypes.map((type) {
                          return VehicleType(
                            label: type.label,
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
