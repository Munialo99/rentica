import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/widgets/double_header_btn.dart';
import 'package:rentica/base/widgets/my_app_bar.dart';
import 'package:rentica/base/widgets/trending_car_card.dart';

import '../base/widgets/car_category.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: CustomScrollView(
        slivers: [
          MyAppBar(
            title: "Trending Vehicles",
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
              child: Align(alignment: Alignment.bottomCenter, child: Text(
                "Incredible Deals, Special Offers &\nDiscount up to 30%",
                textAlign: TextAlign.center,
                style: AppStyles.headlineStyle2
                    .copyWith(color: AppStyles.whiteColor, fontSize: 18, fontWeight: FontWeight.normal),
              ),),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [SizedBox(height: 20,),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...List.generate(5, (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: TrendingCarCard(isFullWidth: true,),
                        )),
                      ],
                    ),),
                  //  Vehicles Type
                  SizedBox(height: 20,),
                  DoubleHeaderButton(bigText: 'Vehicle Type', smallText: 'View All', tinyTextVisible: true, tinyText: 'Find What You Want', func: () {  },),
                  SizedBox(height: 20,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarCategory(icon: Icons.directions_car, label: 'Sedan'),
                        CarCategory(icon: Icons.directions_car_filled, label: 'Hatchback'),
                        CarCategory(icon: Icons.directions_car_filled, label: 'SUV'),
                        CarCategory(icon: Icons.airport_shuttle, label: 'Van'),
                        CarCategory(icon: Icons.directions_bus, label: 'Bus'),
                        CarCategory(icon: Icons.local_shipping, label: 'Truck'),
                      ],
                    ),),
                  SizedBox(height: 60,),
                ],
              ),
            ),
          ]),),
        ],
      ),
    );
  }
}
