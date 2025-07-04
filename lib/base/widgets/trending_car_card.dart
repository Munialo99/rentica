import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class TrendingCarCard extends StatelessWidget {
  final bool isFullWidth;
  const TrendingCarCard({super.key, this.isFullWidth = false});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: isFullWidth ? deviceWidth : deviceWidth * 0.75,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
            child: Image.network(
              'https://img.freepik.com/free-photo/black-suv-parking-asphalt-road_114579-4001.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Product name
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nissan Rogue 2023",
                          style: AppStyles.headlineStyle3.copyWith(color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Location row
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: AppStyles.textGrey,),
                        const SizedBox(width: 4),
                        Text(
                          "Nairobi, Kenya",
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
                        Icon(Icons.star, size: 16,  color: AppStyles.textGrey),
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
                      "KES. 3,500",
                      style: AppStyles.headlineStyle3.copyWith(color: Colors.black87),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppStyles.primaryColor,
                        borderRadius: BorderRadius.circular(5),

                      ),
                      child: Text(
                        'Sedan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
