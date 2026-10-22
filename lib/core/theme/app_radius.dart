import 'package:flutter/material.dart';

/// App-wide border radius constants
/// Ensures consistent corner rounding across all UI elements
class AppRadius {
  static const double xs = 2.0;
  static const double small = 4.0;
  static const double medium = 8.0;
  static const double large = 12.0;
  static const double xLarge = 16.0;
  static const double xxLarge = 20.0;
  static const double hero = 24.0;
  static const double pill = 56.0;

  // Pre-defined BorderRadius objects for common use cases
  static const BorderRadius smallAll = BorderRadius.all(Radius.circular(small));
  static const BorderRadius mediumAll = BorderRadius.all(
    Radius.circular(medium),
  );
  static const BorderRadius largeAll = BorderRadius.all(Radius.circular(large));
  static const BorderRadius xLargeAll = BorderRadius.all(
    Radius.circular(xLarge),
  );
  static const BorderRadius xxLargeAll = BorderRadius.all(
    Radius.circular(xxLarge),
  );
  static const BorderRadius pillAll = BorderRadius.all(Radius.circular(pill));
}
