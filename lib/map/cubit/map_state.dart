part of 'map_cubit.dart';

enum LocationStaus { initial, loading, success, failure }

final class MapState extends Equatable {
  const MapState({
    this.status = LocationStaus.initial,
    this.isMoving = false,
    this.position = MapRepository.almatyLatLng,
    this.error,
  });

  MapState copyWith({
    bool? isMoving,
    LatLng? position,
    String? error,
    LocationStaus? status,
  }) {
    return MapState(
      status: status ?? this.status,
      isMoving: isMoving ?? this.isMoving,
      position: position ?? this.position,
      error: error ?? this.error,
    );
  }

  final bool isMoving;
  final LatLng position;
  final String? error;
  final LocationStaus status;

  @override
  List<Object> get props => [position, isMoving, status];
}
