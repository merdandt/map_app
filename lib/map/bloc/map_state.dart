part of 'map_bloc.dart';

enum PositioningStatus { initial, loading, success, failure }

sealed class MapState extends Equatable {
  const MapState();
}

final class MapOnFocus extends MapState {
  const MapOnFocus({this.position = MapRepository.almatyPosition});
  final Position position;

  @override
  List<Object?> get props => [position];
}

final class MapOnMoving extends MapState {
  @override
  List<Object?> get props => [];
}

class MapOnDecoding extends MapEvent {
  const MapOnDecoding({
    this.status = PositioningStatus.initial,
    this.nominatTitle = '',
    this.error = '',
  });

  final PositioningStatus status;
  final String nominatTitle;
  final String error;

  MapOnDecoding copyWith(
    PositioningStatus? status,
    String? nominatTitle,
    String? error,
  ) {
    return MapOnDecoding(
      status: status ?? this.status,
      nominatTitle: nominatTitle ?? this.nominatTitle,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, nominatTitle, error];
}

class MapOnSelfPositioning extends MapEvent {
  const MapOnSelfPositioning({
    this.status = PositioningStatus.initial,
    this.nominatTitle = '',
    this.error = '',
  });

  final PositioningStatus status;
  final String nominatTitle;
  final String error;

  MapOnSelfPositioning copyWith(
    PositioningStatus? status,
    String? nominatTitle,
    String? error,
  ) {
    return MapOnSelfPositioning(
      status: status ?? this.status,
      nominatTitle: nominatTitle ?? this.nominatTitle,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, nominatTitle, error];
}
