import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_repository/map_repository.dart';

part './decoder_state.dart';

class DecodedCubit extends Cubit<DecoderState> {
  DecodedCubit(this._mapRepository) : super(const DecoderState());
  final MapRepository _mapRepository;

  Future<void> fetchNominat(LatLng latLng) async {
    emit(state.copyWith(status: DecoderStaus.loading));
    try {
      final nominat = await _mapRepository.getNominatium(latLng);
      if (nominat != null) {
        return emit(
          state.copyWith(
            status: DecoderStaus.success,
            message: nominat.data.displayName,
          ),
        );
      }
      emit(
        state.copyWith(
          status: DecoderStaus.failure,
          message: 'Some error',
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: DecoderStaus.failure, message: e.toString()));
    }
  }
}
