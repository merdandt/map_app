import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_app_ui/src/generated/assets.gen.dart';

abstract class UIIcon {
  SvgPicture pinIcon({double? size, Color? color}) {
    return Assets.icons.pinIcon.svg(
      color: color,
      height: size ?? 14,
      width: size ?? 14,
    );
  }

  SvgPicture refresh({double? size, Color? color}) {
    return Assets.icons.refresh.svg(
      color: color,
      height: size ?? 14,
      width: size ?? 14,
    );
  }

  SvgPicture location({double? size, Color? color}) {
    return Assets.icons.location.svg(
      color: color,
      height: size ?? 14,
      width: size ?? 14,
    );
  }
}
