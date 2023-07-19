import 'package:map_app_ui/map_app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UIIconsDark extends UIIcon {
  @override
  SvgPicture pinIcon({double? size, Color? color}) {
    return super.pinIcon(
      color: color ?? UIColors.white,
      size: size ?? 14,
    );
  }

  @override
  SvgPicture refresh({double? size, Color? color}) {
    return super.refresh(
      color: color ?? UIColors.white,
      size: size ?? 14,
    );
  }

  @override
  SvgPicture location({double? size, Color? color}) {
    return super.location(
      color: color ?? UIColors.white,
      size: size ?? 14,
    );
  }
}
