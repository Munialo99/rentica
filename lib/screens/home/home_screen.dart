import 'package:flutter/material.dart';
import 'package:rentica/base/data/vehicle_types_data.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/data/mock%20data/car_rental_list.dart';
import 'package:rentica/base/widgets/car_search_bar.dart';
import 'package:rentica/base/widgets/cards/car_card_primary.dart';
import 'package:rentica/base/widgets/cards/car_card_secondary.dart';
import 'package:rentica/base/widgets/double_header_btn.dart';
import 'package:rentica/base/widgets/my_app_bar.dart';

import 'package:rentica/base/widgets/cards/vehicle_type.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                //Todo: Implement
              },
              icon: Icon(Icons.menu_rounded, color: AppStyles.whiteColor),
            ),
            actionWidget: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/profile_screen");
              },
              child: CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(
                  'https://img.freepik.com/premium-photo/republic-kenya-national-fabric-flag-textile-background-symbol-international-world-african-country_113767-2562.jpg',
                ),
              ),
            ),
            title: "Rentica",
            centerSection: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Kabuda",
                      style: AppStyles.headlineStyle1.copyWith(
                        color: AppStyles.whiteColor,
                        fontSize: 27,
                      ),
                    ),
                    Text(
                      "Find your perfect ride",
                      style: AppStyles.textStyle2
                          .copyWith(color: AppStyles.whiteColor),
                    ),
                  ],
                ),
              ),
            ),
            lowerSection: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: CarSearchBar(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Top Trends
                    DoubleHeaderButton(
                      bigText: 'Trending Vehicles',
                      smallText: 'View All',
                      tinyTextVisible: true,
                      tinyText: 'Planning Your Trip?',
                      func: () {
                        Navigator.pushNamed(context, '/trending_cars');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: trendingCars.take(4).map((singleCar) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: CarCardSecondary(
                              carData: singleCar,
                              isFullWidth: false,
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
                      isVisible: false,
                      tinyTextVisible: true,
                      tinyText: 'Find What You Want',
                      func: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //Vehicle Types
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
                    //Popular Vehicles
                    SizedBox(
                      height: 20,
                    ),
                    DoubleHeaderButton(
                      bigText: 'Popular Vehicles',
                      smallText: 'View All',
                      tinyTextVisible: true,
                      tinyText: 'The perfect car for your trip',
                      func: () {
                        Navigator.pushNamed(context, '/popular_vehicles_screen');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Popular Vehicles
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: popularCars
                            .take(4)
                            .map((singleCar) => Padding(
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  child: CarCardSecondary(
                                    carData: singleCar,
                                    isFullWidth: true,
                                  ),
                                ))
                            .toList(),
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
