// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';

class WaterDropPainter extends CustomClipper<Path> {
  const WaterDropPainter();
  @override
  Path getClip(Size size) {
    // path_0.close();
    final path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.9876318);
    path_0.lineTo(size.width * 0.1464444, size.height * 0.6983591);
    path_0.cubicTo(
      size.width * 0.07651889,
      size.height * 0.6411455,
      size.width * 0.02889928,
      size.height * 0.5682545,
      size.width * 0.009607111,
      size.height * 0.4889000,
    );
    path_0.cubicTo(
      size.width * -0.009685000,
      size.height * 0.4095432,
      size.width * 0.0002170472,
      size.height * 0.3272886,
      size.width * 0.03806106,
      size.height * 0.2525373,
    );
    path_0.cubicTo(
      size.width * 0.07590500,
      size.height * 0.1777859,
      size.width * 0.1399911,
      size.height * 0.1138950,
      size.width * 0.2222156,
      size.height * 0.06894409,
    );
    path_0.cubicTo(
      size.width * 0.3044400,
      size.height * 0.02399264,
      size.width * 0.4011100,
      0,
      size.width * 0.5000000,
      0,
    );
    path_0.cubicTo(
      size.width * 0.5988889,
      0,
      size.width * 0.6955611,
      size.height * 0.02399264,
      size.width * 0.7777833,
      size.height * 0.06894409,
    );
    path_0.cubicTo(
      size.width * 0.8600111,
      size.height * 0.1138950,
      size.width * 0.9240944,
      size.height * 0.1777859,
      size.width * 0.9619389,
      size.height * 0.2525373,
    );
    path_0.cubicTo(
      size.width * 0.9997833,
      size.height * 0.3272886,
      size.width * 1.009683,
      size.height * 0.4095432,
      size.width * 0.9903944,
      size.height * 0.4889000,
    );
    path_0.cubicTo(
      size.width * 0.9711000,
      size.height * 0.5682545,
      size.width * 0.9234833,
      size.height * 0.6411455,
      size.width * 0.8535556,
      size.height * 0.6983591,
    );
    path_0.lineTo(size.width * 0.5000000, size.height * 0.9876318);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
