import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:map_repository/map_repository.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this._mapRepository) : super(const MapState());

  void startMoving() {
    emit(
      state.copyWith(
        isMoving: true,
        status: LocationStaus.success,
      ),
    );
  }

  void endMoving(LatLng latLng) {
    emit(state.copyWith(isMoving: false, position: latLng));
  }

  Future<void> locateDevice() async {
    emit(state.copyWith(status: LocationStaus.loading, isMoving: true));
    try {
      final myLocation = await _mapRepository.getCurrentPosition();
      if (myLocation != null) {
        emit(
          state.copyWith(
            position: myLocation.toLatLng(),
            status: LocationStaus.success,
          ),
        );
        endMoving(myLocation.toLatLng());
      } else {
        emit(state.copyWith(error: 'Some Error'));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  final MapRepository _mapRepository;
}
