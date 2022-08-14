import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

Widget progressIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(green),
  );
}
