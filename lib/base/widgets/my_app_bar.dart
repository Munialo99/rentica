import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_images.dart';
import 'package:rentica/base/res/app_styles.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Widget? centerSection;
  final Widget? lowerSection;
  final Widget leadingWidget;
  final Widget actionWidget;

  const MyAppBar({
    super.key,
    required this.title,
    this.centerSection,
    this.lowerSection, required this.leadingWidget, required this.actionWidget,
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
      leading: leadingWidget,

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: actionWidget,
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
                AppImages.appBarBackground,
                fit: BoxFit.cover,
              ),
              Container(color: Colors.black.withValues(alpha: 0.65)),

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
