import 'package:flutter/material.dart';

extension MediaSize on BuildContext {
  double widthPercent(double percent) =>
      MediaQuery.sizeOf(this).width * percent;

  double heightPercent(double percent) =>
      MediaQuery.sizeOf(this).height * percent;
}
