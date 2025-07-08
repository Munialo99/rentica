import 'package:flutter/material.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/res/app_styles.dart';

class VehicleTypeStyles {
  static const Map<String, String> _svgIconPathMap = {
    'SUV': AppIcons.suv,
    'Sedan': AppIcons.sedan,
    'Hatchback': AppIcons.hatchback,
    'Pickup Truck': AppIcons.pickupTruck,
    'Van': AppIcons.van,
    'Luxury': AppIcons.luxury,
    'Convertible': AppIcons.convertible,
    'Coupe': AppIcons.coupe,
    'Sports Car': AppIcons.sportsCar,
    'Electric': AppIcons.electric,
    'Hybrid': AppIcons.hybrid,
    'Bus': AppIcons.bus,
    'Motorbike': AppIcons.motorbike,
    'Campervan': AppIcons.campervan,
  };

  static final Map<String, Color> _colorMap = {
    'SUV': AppStyles.suvColor,
    'Sedan': AppStyles.sedanColor,
    'Hatchback': AppStyles.hatchbackColor,
    'Pickup Truck': AppStyles.pickupTruckColor,
    'Van': AppStyles.vanColor,
    'Minivan': AppStyles.minivanColor,
    'Luxury': AppStyles.luxuryColor,
    'Convertible': AppStyles.convertibleColor,
    'Coupe': AppStyles.coupeColor,
    'Sports Car': AppStyles.sportsCarColor,
    'Electric': AppStyles.electricColor,
    'Hybrid': AppStyles.hybridColor,
    'Bus': AppStyles.busColor,
    'Motorbike': AppStyles.motorbikeColor,
    'Campervan': AppStyles.campervanColor,
  };

  static String getSvgIcon(String type) =>
      _svgIconPathMap[type] ?? AppIcons.defaultCar;

  static Color getColor(String type) =>
      _colorMap[type] ?? Colors.grey;
}
