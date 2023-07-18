part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();
}

final class MovingStarted extends MapEvent {
  @override
  List<Object?> get props => [];
}

final class FocusEnded extends MapEvent {
  const FocusEnded({required this.position});

  final Position position;

  @override
  List<Object?> get props => [position];
}

final class DecodingRequested extends MapEvent {
  const DecodingRequested();
  @override
  List<Object?> get props => [];
}

final class SelfPositionRequested extends MapEvent {
  const SelfPositionRequested();
  @override
  List<Object?> get props => [];
}
