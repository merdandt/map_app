import 'package:flutter/material.dart';

import 'colors.dart';

abstract class UIShadows {
  /// Color grey, radius 3, offset(0,1)
  static final midShadow = [
    const BoxShadow(
      color: UIColors.grey,
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];
}
