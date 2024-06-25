import 'package:flutter/material.dart';

class FontSize {
  FontSize._();
  static const double fontSizeSmall = 8;
  static const double fontSizeMedium = 12;
  static const double fontSizeRegular = 14;
  static const double fontSizeBig = 16;
  static const double fontSizeTitle = 18;
  static const double fontSizeHuge = 20;
}

class AppRadius {
  AppRadius._();
  static final small = BorderRadius.circular(2);
  static final medium = BorderRadius.circular(4);
  static final regular = BorderRadius.circular(8);
  static final big = BorderRadius.circular(12);
  static final huge = BorderRadius.circular(16);
}

class HorizontalSpacing {
  HorizontalSpacing._();
  static const small = SizedBox(width: 4);
  static const medium = SizedBox(width: 8);
  static const regular = SizedBox(width: 12);
  static const big = SizedBox(width: 16);
  static const huge = SizedBox(width: 20);
}

/// regular 12 ++ 4
class VerticalSpacing {
  VerticalSpacing._();
  static const small = SizedBox(height: 4);
  static const medium = SizedBox(height: 8);
  static const regular = SizedBox(height: 12);
  static const big = SizedBox(height: 16);
  static const huge = SizedBox(height: 20);
}
