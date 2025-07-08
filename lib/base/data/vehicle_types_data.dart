import 'package:flutter/material.dart';
import 'package:rentica/base/data/mock%20data/car_rental_list.dart';
import 'package:rentica/base/res/vehicle_type_style.dart';

class UniqueVehicleType {
  final String label;
  final String svgIconPath;

  UniqueVehicleType({required this.label, required this.svgIconPath});
}

List<UniqueVehicleType> getUniqueVehicleTypes() {
  Set<String> uniqueTypes = {};
  List<UniqueVehicleType> vehicleTypeList = [];

  for (var car in carRentalList) {
    String carType = car['carType'] as String;
    if (!uniqueTypes.contains(carType)) {
      uniqueTypes.add(carType);
      vehicleTypeList.add(UniqueVehicleType(
        label: carType,
        svgIconPath: VehicleTypeStyles.getSvgIcon(carType),
      ));
    }
  }
  return vehicleTypeList;
}

final List<Map<String, dynamic>> allCarRentalList = carRentalList;