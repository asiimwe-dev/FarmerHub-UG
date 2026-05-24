/// Validators for field-related data (farm plots, measurements)
class FieldValidators {
  /// Validate field name (2-100 chars)
  static String? validateFieldName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field name is required';
    }
    if (value.length < 2) {
      return 'Field name must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'Field name cannot exceed 100 characters';
    }
    return null;
  }
  
  /// Validate field area in hectares (0.01 - 10000)
  static String? validateArea(String? value) {
    if (value == null || value.isEmpty) {
      return 'Area is required';
    }
    final area = double.tryParse(value);
    if (area == null) {
      return 'Area must be a valid number';
    }
    if (area < 0.01) {
      return 'Area must be at least 0.01 hectares';
    }
    if (area > 10000) {
      return 'Area cannot exceed 10000 hectares';
    }
    return null;
  }
  
  /// Validate GPS coordinates (latitude, longitude)
  static String? validateLatitude(String? value) {
    if (value == null || value.isEmpty) {
      return 'Latitude is required';
    }
    final lat = double.tryParse(value);
    if (lat == null) {
      return 'Latitude must be a valid number';
    }
    if (lat < -90 || lat > 90) {
      return 'Latitude must be between -90 and 90';
    }
    return null;
  }
  
  static String? validateLongitude(String? value) {
    if (value == null || value.isEmpty) {
      return 'Longitude is required';
    }
    final lon = double.tryParse(value);
    if (lon == null) {
      return 'Longitude must be a valid number';
    }
    if (lon < -180 || lon > 180) {
      return 'Longitude must be between -180 and 180';
    }
    return null;
  }
}

/// Validators for crop data
class CropValidators {
  /// Validate crop type is in supported list
  static String? validateCropType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Crop type is required';
    }
    const supportedCrops = [
      'Maize', 'Beans', 'Coffee', 'Cotton', 'Cassava',
      'Banana', 'Rice', 'Wheat', 'Sorghum'
    ];
    if (!supportedCrops.contains(value)) {
      return 'Unsupported crop type: $value';
    }
    return null;
  }
  
  /// Validate planting date
  static String? validatePlantingDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Planting date is required';
    }
    try {
      DateTime.parse(value);
      return null;
    } catch (_) {
      return 'Invalid date format';
    }
  }
}

/// Validators for yield measurements
class MeasurementValidators {
  /// Validate yield value (must be positive)
  static String? validateYield(String? value) {
    if (value == null || value.isEmpty) {
      return 'Yield is required';
    }
    final yield = double.tryParse(value);
    if (yield == null) {
      return 'Yield must be a valid number';
    }
    if (yield <= 0) {
      return 'Yield must be greater than 0';
    }
    return null;
  }
  
  /// Validate yield unit
  static String? validateYieldUnit(String? value) {
    if (value == null || value.isEmpty) {
      return 'Unit is required';
    }
    const validUnits = ['kg/ha', 'bags/ha', 'tons/ha'];
    if (!validUnits.contains(value)) {
      return 'Invalid unit: $value';
    }
    return null;
  }
}
