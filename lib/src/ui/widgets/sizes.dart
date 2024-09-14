import 'package:flutter/material.dart';

class SizeUtils {
  static double bodyWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double fullHeight(context) => MediaQuery.of(context).size.height;
  static double bodyHeight(context) =>MediaQuery.of(context).size.height -
      AppBar().preferredSize.height -
      MediaQuery.of(context).viewPadding.top;
}
