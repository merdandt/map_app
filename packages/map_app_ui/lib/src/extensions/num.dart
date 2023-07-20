import 'package:flutter/material.dart';

extension SpasingExtensions on num {
  EdgeInsets edgeInsetsAll() {
    return EdgeInsets.all(
      toDouble(),
    );
  }

  EdgeInsets edgeInsetsLTRB({
    bool? left,
    bool? top,
    bool? right,
    bool? bottom,
  }) {
    return EdgeInsets.fromLTRB(
      left == null ? 0.0 : toDouble(),
      left == null ? 0.0 : toDouble(),
      left == null ? 0.0 : toDouble(),
      left == null ? 0.0 : toDouble(),
    );
  }

  EdgeInsets edgeInsetsSymmetric({bool? v, bool? h}) => EdgeInsets.symmetric(
        vertical: v == null ? 0.0 : toDouble(),
        horizontal: h == null ? 0.0 : toDouble(),
      );
}
