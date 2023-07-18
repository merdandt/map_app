part of 'map_cubit.dart';

final class MapState extends Equatable {
  const MapState({
    this.isMoving = false,
    this.position = MapRepository.almatyLatLng,
    this.error,
  });

  MapState copyWith({
    bool? isMoving,
    LatLng? position,
    String? error,
  }) {
    return MapState(
      isMoving: isMoving ?? this.isMoving,
      position: position ?? this.position,
      error: error ?? this.error,
    );
  }

  final bool isMoving;
  final LatLng position;
  final String? error;

  @override
  List<Object> get props => [position, isMoving];
}
