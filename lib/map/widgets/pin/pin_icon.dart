import 'package:flutter/material.dart';

import 'package:map_app/map/helpers/helpers.dart';
import 'package:map_app_ui/map_app_ui.dart';

class PinIcon extends StatelessWidget {
  const PinIcon({
    this.size = UISpacing.h,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    final width = size * 0.81818181;
    return ClipShadowPath(
      shadow: BoxShadow(
        color: Colors.black.withOpacity(.3),
        spreadRadius: 3,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
      clipper: const WaterDropPainter(),
      child: Container(
        width: width,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Align(
          alignment: Alignment(0, -(size * 0.0085)),
          child: const Icon(Icons.location_searching_rounded),
        ),
      ),
    );
  }
}
