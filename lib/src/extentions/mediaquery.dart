import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  double get screenWidth {
   return MediaQuery.of(this).size.width;
  }

  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isMobile => screenWidth < 600;

  bool get isTablet => screenWidth >= 600 && screenWidth < 1100;

  bool get isDesktop => screenWidth >= 1100;

  double percentWidth(double percentage) => screenWidth * (percentage / 100);

  double percentHeight(double percentage) => screenHeight * (percentage / 100);

  double responsiveFontSize(double baseFontSize) {
    if (isMobile) return baseFontSize;
    if (isTablet) return baseFontSize * 1.2;
    return baseFontSize * 1.4;
  }
}
