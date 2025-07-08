import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentica/base/res/app_icons.dart';

String getCarModelIcon(String carModel) {
  final String lowerCaseModel = carModel.toLowerCase();

  switch (lowerCaseModel) {
    case 'toyota':
      return AppIcons.toyota;
    case 'honda':
      return AppIcons.honda;
    case 'tesla':
      return AppIcons.tesla;
    case 'suzuki':
      return AppIcons.suzuki;
    case 'land rover':
      return AppIcons.landrover;
    case 'mercedes-benz':
      return AppIcons.mercedesBenz;
    case 'bmw':
      return AppIcons.bmw;
    case 'nissan':
      return AppIcons.nissan;
    case 'ford':
      return AppIcons.ford;
    case 'kia':
      return AppIcons.kia;
    case 'hyundai':
      return AppIcons.hyundai;
    case 'volkswagen':
      return AppIcons.volkswagen;
    case 'mazda':
      return AppIcons.mazda;
    case 'subaru':
      return AppIcons.subaru;
    default:
      return AppIcons.carSports;
  }
}

class CarIconMapper {
  static final Map<String, String> _svgIconPathMap = {
    'person': AppIcons.carSeatWithSeatbelt,
    'fuel': AppIcons.fuel,
    'consumption': AppIcons.fire,
    'transmission': AppIcons.transmission,
    'driveType': AppIcons.allWheelDrive,
    'engine': AppIcons.engineMotor,
    'baggage': AppIcons.luggage,
    'ac': AppIcons.ac,
  };

  static const String _defaultSvgPath = AppIcons.carSports;

  static String getSvgIconPath(String iconKey) {
    return _svgIconPathMap[iconKey] ?? _defaultSvgPath;
  }
}
