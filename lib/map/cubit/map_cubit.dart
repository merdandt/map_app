import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:map_repository/map_repository.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this._mapRepository) : super(const MapState());

  void startMoving() {
    emit(state.copyWith(isMoving: true));
  }

  void endMoving(LatLng latLng) {
    emit(state.copyWith(isMoving: false, position: latLng));
  }

  Future<void> locateDevice() async {
    try {
      final myLocation = await _mapRepository.getCurrentPosition();
      if (myLocation != null) {
        emit(state.copyWith(position: myLocation.toLatLng()));
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
