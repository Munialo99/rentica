import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/res/vehicle_type_style.dart';

class VehicleType extends StatelessWidget {
  final String label;
  final Color? iconColor;
  final Color? labelColor;

  const VehicleType({
    super.key,
    required this.label, this.iconColor, this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 100,),
      child: Container(
        //width: 80,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
         // color: Colors.white,
color:AppStyles.textWhite,
         // border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(VehicleTypeStyles.getSvgIcon(label),
                //width: 30,
                height: 20,
                colorFilter: ColorFilter.mode(iconColor ?? AppStyles.textDarkGrey, BlendMode.srcIn)
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppStyles.textStyle.copyWith(fontSize: 14, color: labelColor ?? AppStyles.textBlack),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
