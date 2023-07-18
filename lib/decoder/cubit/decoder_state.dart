part of 'decoder_cubit.dart';

enum DecoderStaus { initial, loading, success, failure }

final class DecoderState extends Equatable {
  const DecoderState({
    this.status = DecoderStaus.initial,
    String? message,
  }) : message = message ?? '';

  DecoderState copyWith({
    DecoderStaus? status,
    String? message,
  }) {
    return DecoderState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  final DecoderStaus status;
  final String message;

  @override
  List<Object> get props => [status, message];
}
