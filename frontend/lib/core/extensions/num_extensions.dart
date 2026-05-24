/// Utility extensions for numeric operations
extension NumExtensions on num {
  /// Convert kilograms to pounds
  double kg2lbs() => this * 2.20462;
  
  /// Convert pounds to kilograms
  double lbs2kg() => this / 2.20462;
  
  /// Convert meters to feet
  double m2ft() => this * 3.28084;
  
  /// Convert hectares to acres
  double ha2ac() => this * 2.47105;
  
  /// Convert acres to hectares
  double ac2ha() => this / 2.47105;
  
  /// Round to n decimal places
  double roundTo(int decimals) {
    final multiplier = pow(10, decimals);
    return (this * multiplier).round() / multiplier;
  }
}

import 'dart:math';
