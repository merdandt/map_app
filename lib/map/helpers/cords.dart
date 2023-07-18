import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';

class Coords<T extends num> extends CustomPoint<T> with EquatableMixin {
  Coords(super.x, super.y);
  late T z;

  Coords<double> wrap(
    (double, double)? wrapX,
    (double, double)? wrapY,
  ) {
    final newCoords = Coords<double>(
      wrapX != null ? wrapNum(x.toDouble(), wrapX) : x.toDouble(),
      wrapY != null ? wrapNum(y.toDouble(), wrapY) : y.toDouble(),
    );
    return newCoords;
  }

  String get key => '$x:$y:$z';

  @override
  String toString() => 'Coords($x, $y, $z)';

  @override
  List<Object?> get props => [x, y, z];
}

double wrapNum(double x, (double, double) range, {bool? includeMax}) {
  final max = range.$2;
  final min = range.$1;
  final d = max - min;
  return x == max && includeMax != null ? x : ((x - min) % d + d) % d + min;
}
