import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:map_repository/map_repository.dart';

part 'map_state.dart';

/// A [Cubit] that handles [MapState]
class MapCubit extends Cubit<MapState> {
  MapCubit(this._mapRepository) : super(const MapState());

  /// Notifies animated lisners that map is moving
  void startMoving() {
    emit(
      state.copyWith(
        isMoving: true,
      ),
    );
  }

  /// Notifies animated lisners that map stopped moving
  void endMoving(LatLng latLng, double zoom) {
    emit(
      state.copyWith(
        isMoving: false,
        position: latLng,
        zoom: zoom,
      ),
    );
  }

  /// Move the focus of the map and select location
  void locateToThePoint(LatLng latLng) {
    emit(
      state.copyWith(
        isMoving: false,
        position: latLng,
        status: LocationStaus.success,
      ),
    );
  }

  /// Method that determines current location of your device
  /// and emits new state
  Future<void> locateDevice() async {
    emit(state.copyWith(status: LocationStaus.loading));
    try {
      final myLocation = await _mapRepository.getCurrentPosition();
      // Emit failure state
      if (myLocation == null) {
        return emit(
          state.copyWith(error: 'Some Error', status: LocationStaus.failure),
        );
      }
      // Debounce emitting unnecessary stare
      if (myLocation.toLatLng() == state.position) {
        return emit(state.copyWith(status: LocationStaus.success));
      }
      // Emit state with new location
      locateToThePoint(myLocation.toLatLng());
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          status: LocationStaus.failure,
          isMoving: false,
        ),
      );
    }
  }

  final MapRepository _mapRepository;
}
