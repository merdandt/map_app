import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:map_repository/map_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc(this._mapRepository) : super(const MapOnFocus()) {
    on<MovingStarted>(_onMoveStarted);
    on<FocusEnded>(_onFocusEnded);
    on<DecodingRequested>(_onDecodingRequested);
    on<SelfPositionRequested>(_onSelfPosisionRequested);
  }

  void _onMoveStarted(MovingStarted event, Emitter<MapState> emit) {
    emit(MapOnMoving());
  }

  void _onFocusEnded(FocusEnded event, Emitter<MapState> emit) {
    emit(MapOnFocus(position: event.position));
  }

  void _onDecodingRequested(DecodingRequested event, Emitter<MapState> emit) {}

  void _onSelfPosisionRequested(
    SelfPositionRequested event,
    Emitter<MapState> emit,
  ) {}

  final MapRepository _mapRepository;
}
