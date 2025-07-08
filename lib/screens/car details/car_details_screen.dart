import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentica/base/data/mock%20data/default_car_features.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/res/vehicle_type_style.dart';
import 'package:rentica/base/models/car_feature_config.dart';
import 'package:rentica/base/utils/car_icon_mapper.dart';
import 'package:rentica/base/widgets/buttons/bottom_nav_btn.dart';
import 'package:rentica/base/widgets/car_image_viewer.dart';
import 'package:rentica/base/widgets/cards/car_feature_card.dart';
import 'package:rentica/base/widgets/cards/vehicle_type_color_card.dart';
import 'package:rentica/base/widgets/double_header_btn.dart';
import 'package:rentica/base/widgets/buttons/favorite_btn.dart';
import 'package:rentica/screens/modal%20screens/book_now_modal_screen.dart';

class CarDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> carData;

  const CarDetailsScreen({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    final imageUrls = (carData['gallery'] as List<dynamic>)
        .map((e) => e['url'] as String)
        .toList();

    final String carId = carData['carId'] ?? '';
    final String carName = carData['carName'];
    final String carModel = carData['carModel'];
    final String carType = carData['carType'];
    final int rentalPrice = carData['rentalPrice'];
    final String description = carData['description'];

    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: AppStyles.whiteColor),
        ),
        title: Text(
          "Car Details",
          style: TextStyle(
            color: AppStyles.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppStyles.darkBlueApp,
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarImageViewer(
              imageUrls: imageUrls,
            ),
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        carName,
                        style: AppStyles.headlineStyle1.copyWith(fontSize: 22),
                      ),
                      FavoriteBtn(
                        id: carId,
                        onChanged: (isFavorited) {
                          //Todo: Implementation
                          if (isFavorited) {
                            print('Added to favorites');
                          } else {
                            print('Removed from favorites');
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Location row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                              AppIcons.numberPlate2,
                              //width: 15,
                              height: 16,
                              colorFilter: ColorFilter.mode(AppStyles.primaryColor, BlendMode.srcIn)
                          ),

                          /*SvgPicture.asset(
                              getCarModelIcon(carModel),
                              //width: 15,
                              height: 16,
                              colorFilter: ColorFilter.mode(AppStyles.primaryColor, BlendMode.srcIn)
                          ),*/
                          SizedBox(width: 5),
                          Text(
                            "$carModel | KDQ 6***",
                            style: AppStyles.textStyle2,
                          ),
                        ],
                      ),
                      VehicleTypeColorCard(label: carType),
                    ],
                  ),

                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppStyles.whiteColor,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      description,
                      style: AppStyles.textStyle2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //Car Overview
                  SizedBox(height: 20),
                  DoubleHeaderButton(
                    bigText: 'Car Overview',
                    smallText: 'View All',
                    tinyTextVisible: true,
                    isVisible: false,
                    tinyText: 'Looking for something amazing?',
                    func: () {},
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                      defaultCarFeatures.map((featureConfig) {
                        final Map<String, dynamic> carOverview = carData['overview'] ?? {};
                        String displayValue;

                        if (featureConfig.valueFormatter != null) {
                          displayValue = featureConfig.valueFormatter!(carOverview) ?? 'N/A';
                        } else {
                          final dynamic rawFeatureValue = carOverview[featureConfig.key];
                          displayValue = rawFeatureValue?.toString() ?? 'N/A';
                        }

                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CarFeatureCard(
                            svgIcon: CarIconMapper.getSvgIconPath(featureConfig.svgString),
                            label: featureConfig.label,
                            value: displayValue,
                          ),
                        );
                      }).toList(), // Convert the map to a list of widgets
                    ),
                  ),
                  //More Images
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ]),
      bottomNavigationBar: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => BookNowModalScreen(carData: carData,),
            );
          },
          child: BottomNavBtn(
            labelText: 'Book Now',
            priceText: '$rentalPrice',
          )),
    );
  }
}
