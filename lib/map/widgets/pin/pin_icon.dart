import 'package:flutter/material.dart';

import 'package:map_app_ui/map_app_ui.dart';

class PinIcon extends StatelessWidget {
  const PinIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const height = UISpacing.pinH;
    const width = height * 0.8;
    return ClipShadowPath(
      shadow: BoxShadow(
        color: UIColors.black.withOpacity(.3),
        spreadRadius: 3,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
      clipper: const WaterDropPainter(),
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: UIColors.white,
        ),
        child: Align(
          alignment: const Alignment(0, -(height * 0.0085)),
          child: theme.icons.pinIcon(
            color: UIColors.black,
            size: UISpacing.xlg,
          ),
        ),
      ),
    );
  }
}
