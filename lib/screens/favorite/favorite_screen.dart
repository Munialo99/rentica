import 'package:flutter/material.dart';
import 'package:rentica/base/data/mock%20data/car_rental_list.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/widgets/cards/car_card_primary.dart';
import 'package:rentica/base/widgets/cards/car_card_secondary.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favorites',
            style:
                AppStyles.headlineStyle1.copyWith(color: AppStyles.textBlack)),
        backgroundColor: AppStyles.whiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: favoriteCars.map((singleCar) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/car_detail_screen',
                      arguments: singleCar);
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
      ),
    );
  }
}
