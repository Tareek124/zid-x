import 'package:flutter/cupertino.dart';

class CustomSize {
  static double? width;
  static double? height;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
    defaultSize =
        orientation == Orientation.landscape ? height! * 0.024 : width! * 0.024;
  }
}
