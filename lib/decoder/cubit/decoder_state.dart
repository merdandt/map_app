part of 'decoder_cubit.dart';

enum DecoderStaus { initial, loading, success, failure }

final class DecoderState extends Equatable {
  const DecoderState({
    this.status = DecoderStaus.initial,
    String? message,
    this.isMoving = false,
  }) : message = message ?? '';

  DecoderState copyWith({
    DecoderStaus? status,
    String? message,
    bool? isMoving,
  }) {
    return DecoderState(
      status: status ?? this.status,
      message: message ?? this.message,
      isMoving: isMoving ?? this.isMoving,
    );
  }

  final DecoderStaus status;
  final String message;
  final bool isMoving;

  @override
  List<Object> get props => [status, message, isMoving];
}
