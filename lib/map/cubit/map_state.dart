part of 'map_cubit.dart';

enum LocationStaus { initial, loading, success, failure }

final class MapState extends Equatable {
  const MapState({
    this.status = LocationStaus.initial,
    this.isMoving = false,
    this.position = MapRepository.ashgabatLatLng,
    this.error,
    this.zoom = 14.0,
  });

  MapState copyWith({
    bool? isMoving,
    LatLng? position,
    String? error,
    LocationStaus? status,
    double? zoom,
  }) {
    return MapState(
      status: status ?? this.status,
      isMoving: isMoving ?? this.isMoving,
      position: position ?? this.position,
      error: error ?? this.error,
      zoom: zoom ?? this.zoom,
    );
  }

  /// If the map is moving
  final bool isMoving;

  /// Focus point of the mep
  final LatLng position;

  /// Extra field for any errors
  final String? error;

  /// Status of the device location
  final LocationStaus status;

  /// Field for map's zoom level
  final double zoom;

  @override
  List<Object> get props => [position, isMoving, status, zoom];
}
