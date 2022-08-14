import 'package:flutter/material.dart';

Color colorMode(BuildContext context) {
  if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
    return Colors.black;
  } else {
    return Colors.white;
  }
}

Color colorModeReversed(BuildContext context) {
  if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}
