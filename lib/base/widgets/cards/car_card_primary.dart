import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/utils/car_icon_mapper.dart';
import 'package:rentica/base/widgets/buttons/favorite_btn.dart';
import 'package:rentica/screens/modal%20screens/book_now_modal_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'vehicle_type_color_card.dart';

class CarCardPrimary extends StatelessWidget {
  final Map<String, dynamic> carData;
  final bool isFullWidth;
  const CarCardPrimary(
      {super.key, this.isFullWidth = false, required this.carData});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    //Extract Car Data
    final String carId = carData['carId'] ?? '';
    final String carName = carData['carName'] ?? '';
    final String carModel = carData['carModel'] ?? '';
    final int rentalPrice = carData['rentalPrice'];
    final String carType = carData['carType'];
    final List<Map<String, dynamic>> gallery =
        (carData['gallery'] as List<dynamic>).cast<Map<String, dynamic>>();

    // Get thumbnail image
    final Map<String, dynamic> thumbnailImage = gallery.firstWhere(
      (img) => img['isThumbnail'] == true,
      orElse: () => gallery.first,
    );

    final String thumbnailUrl = thumbnailImage['url'];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/car_detail_screen', arguments: carData);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        width: isFullWidth ? deviceWidth : deviceWidth * 0.75,
        //height: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
                child: Image.network(
                  thumbnailUrl.trim(),
                  height: 150,
                  width: isFullWidth ? deviceWidth : deviceWidth * 0.75,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: FavoriteBtn(
                id: carId,
                onChanged: (isFavorited) {
                  //Todo: Implementation
                  if (isFavorited) {
                    print('Added to favorites');
                  } else {
                    print('Removed from favorites');
                  }
                },
              ),)
            ]),
            //Product Details
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name
                      Text(
                        carName,
                        style: AppStyles.headlineStyle3
                            .copyWith(color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Location row
                      Row(
                        children: [
                          SvgPicture.asset(getCarModelIcon(carModel),
                              //width: 15,
                              height: 14,
                              colorFilter: ColorFilter.mode(
                                  AppStyles.textGrey, BlendMode.srcIn)),
                          const SizedBox(width: 4),
                          Text(
                            carModel,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppStyles.textGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Rating row
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.numberPlate2,
                              //width: 15,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                  AppStyles.textGrey, BlendMode.srcIn)),
                          //  Icon(Icons.star, size: 16, color: AppStyles.textGrey),
                          const SizedBox(width: 4),
                          Text(
                            "4.9 (30 Trips)",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppStyles.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Pricing/day, Type of Car
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "KES. ${rentalPrice.toStringAsFixed(0)}",
                        style: AppStyles.headlineStyle3
                            .copyWith(color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "/day",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppStyles.textGrey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Vehicle Type
                      VehicleTypeColorCard(label: carType),
                    ],
                  ),
                ],
              ),
            ),
            //Book Now Button
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => BookNowModalScreen(
                      carData: carData,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppStyles.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 30,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Book Now',
                        style: AppStyles.textStyle.copyWith(
                            color: AppStyles.whiteColor, fontSize: 14),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
