import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/utils/car_icon_mapper.dart';
import 'package:rentica/base/widgets/cards/vehicle_type_color_card.dart';
import 'package:rentica/base/widgets/dialogs/image_gallery_dialog.dart';

class VehicleSummaryCard extends StatelessWidget {
  final Map<String, dynamic> carData;
  const VehicleSummaryCard({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    final String carName = carData['carName'] ?? '';
    final String carModel = carData['carModel'] ?? '';
    final String carType = carData['carType'] ?? '';

    final List<String> imageUrls = (carData['gallery'] as List<dynamic>?)
        ?.map((e) => e['url'] as String)
        .toList() ??
        [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: AppStyles.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Vehicle Name
                Expanded(
                  child: Text(
                    carName,
                    style: AppStyles.headlineStyle2.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove_red_eye_rounded, color: AppStyles.primaryColor, size: 20,),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ImageGalleryDialog(
                          carName: carName,
                          imageUrls: imageUrls,
                        );
                      },
                    );
                  },
                  tooltip: 'View Gallery', // Optional tooltip
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            // Car Model & type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Car Model
                Row(
                  children: [
                    SvgPicture.asset(
                        getCarModelIcon(carModel),
                        //width: 15,
                        height: 14,
                        colorFilter: ColorFilter.mode(AppStyles.primaryColor, BlendMode.srcIn)
                    ),
                    SizedBox(width: 4), // spacing between icon and text
                    Text(
                      "$carModel | KDQ 6***",
                      style: AppStyles.headlineStyle3.copyWith(
                        color: AppStyles.textGrey,
                        fontSize: 12, // optional: control text size
                      ),
                      // Vehicle Type
                    ),
                  ],
                ),
                // Car Type
                VehicleTypeColorCard(label: carType,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


