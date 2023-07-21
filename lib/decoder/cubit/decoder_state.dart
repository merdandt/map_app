part of 'decoder_cubit.dart';

/// Status of the `status` field of [DecoderState]
enum DecoderStaus { initial, loading, success, failure }

/// A Class that defines the state of the Decoding
final class DecoderState extends Equatable {
  const DecoderState({
    this.status = DecoderStaus.initial,
    String? retrievedName,
    this.isMoving = false,
  }) : retrievedName = retrievedName ?? '';

  DecoderState copyWith({
    DecoderStaus? status,
    String? retrievedName,
    bool? isMoving,
  }) {
    return DecoderState(
      status: status ?? this.status,
      retrievedName: retrievedName ?? this.retrievedName,
      isMoving: isMoving ?? this.isMoving,
    );
  }

  /// Current status
  final DecoderStaus status;

  /// Address of the current coordinates
  final String retrievedName;

  /// Property responsible for animation
  final bool isMoving;

  @override
  List<Object> get props => [status, retrievedName, isMoving];
}
