import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_repository/map_repository.dart';

part './decoder_state.dart';

/// [Cubit] that handles the logic of decoding coordinates to address
class DecodedCubit extends Cubit<DecoderState> {
  /// Construction with the provided [MapRepository] for accessing
  /// decoding data
  DecodedCubit(this._mapRepository) : super(const DecoderState());

  /// instance of [MapRepository]
  final MapRepository _mapRepository;

  /// Toogling the `isMoving` property of the [DecoderState]
  void toggleMoving({required bool val}) {
    emit(state.copyWith(isMoving: val));
  }

  /// Method for convertin [LatLng] for address and emiting new state
  Future<void> fetchGeoCoding(LatLng latLng) async {
    emit(state.copyWith(status: DecoderStaus.loading));
    try {
      final nominat = await _mapRepository.getGeoCoding(latLng);
      if (nominat != null) {
        return emit(
          state.copyWith(
            status: DecoderStaus.success,
            retrievedName: nominat.data.displayName,
          ),
        );
      }
      emit(
        state.copyWith(
          status: DecoderStaus.failure,
          retrievedName: 'Some error',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DecoderStaus.failure,
          retrievedName: e.toString(),
        ),
      );
    }
  }
}
