import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_styles.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Widget? centerSection;
  final Widget? lowerSection;

  const MyAppBar({
    super.key,
    required this.title,
    this.centerSection,
    this.lowerSection,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasExtras = centerSection != null || lowerSection != null;

    return SliverAppBar(
      backgroundColor: Colors.black87,
      expandedHeight: hasExtras ? 300 : 150,
      floating: false,
      pinned: true,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: AppStyles.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu_rounded, color: AppStyles.whiteColor),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(
              'https://img.freepik.com/premium-photo/republic-kenya-national-fabric-flag-textile-background-symbol-international-world-african-country_113767-2562.jpg',
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                "https://img.freepik.com/free-photo/afroamerican-friends-leaning-car_23-2148422412.jpg",
                fit: BoxFit.cover,
              ),
              Container(color: Colors.black.withOpacity(0.65)),

              if (centerSection != null)
                centerSection!,

              if (lowerSection != null)
                lowerSection!,
            ],
          ),
        ),
      ),
    );
  }
}
