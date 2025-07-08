
import 'package:rentica/base/models/car_feature_config.dart';

final List<CarFeatureConfig> defaultCarFeatures = [
  CarFeatureConfig(
    key: 'seatingCapacity',
    svgString: 'person', 
    label: 'Capacity',
    valueFormatter: (overview) {
      final capacity = overview['seatingCapacity'];
      return capacity != null ? '$capacity Seats' : 'N/A';
    },
  ),
  CarFeatureConfig(
    key: 'fuelType',
    svgString: 'fuel', 
    label: 'Fuel',
  ),
  CarFeatureConfig(
    key: 'fuelConsumption',
    svgString: 'consumption', 
    label: 'Consumption',
    valueFormatter: (overview) {
      final consumption = overview['fuelConsumption'];
      return consumption != null ? '$consumption' : 'N/A'; // Example formatter
    },
  ),
  CarFeatureConfig(
    key: 'transmission',
    svgString: 'transmission', 
    label: 'Transmission',
  ),
  CarFeatureConfig(
    key: 'driveType',
    svgString: 'driveType', 
    label: 'Drive Type',
  ),
];