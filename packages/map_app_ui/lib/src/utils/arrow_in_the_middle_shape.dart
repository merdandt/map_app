import 'package:flutter/rendering.dart';

class ArrowMiddleBottomShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only(bottom: 20);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const arrowSize = 20.0;
    final arrowPosition =
        rect.bottomCenter - const Offset(arrowSize, arrowSize);

    // ignore: parameter_assignments
    rect = Rect.fromPoints(
      rect.topLeft,
      rect.bottomRight - const Offset(0, arrowSize),
    );
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(7)))
      ..moveTo(arrowPosition.dx, arrowPosition.dy)
      ..relativeLineTo(arrowSize, arrowSize / 2)
      ..relativeLineTo(arrowSize, -arrowSize / 2)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
