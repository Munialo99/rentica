import 'package:flutter_svg/flutter_svg.dart';

typedef FeatureValueFormatter = String? Function(Map<String, dynamic> overview);

class CarFeatureConfig {
  final String key; // Key to find the value in carData['overview']
  final String svgString;
  final String label;
  final FeatureValueFormatter? valueFormatter; // custom formatter

  const CarFeatureConfig({
    required this.key,
    required this.svgString,
    required this.label,
    this.valueFormatter,
  });
}