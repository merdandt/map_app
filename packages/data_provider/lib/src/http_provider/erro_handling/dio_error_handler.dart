import 'package:dio/dio.dart';

///
class DioExceptionHandler implements Exception {
  ///
  DioExceptionHandler.fromDioError({
    required DioException dioError,
  }) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'Request to the server was cancelled.';
      case DioExceptionType.connectionTimeout:
        message = 'Connection timed out.';
      case DioExceptionType.receiveTimeout:
        message = 'Receiving timeout occurred.';
      case DioExceptionType.sendTimeout:
        message = 'Request send timeout.';
      case DioExceptionType.badResponse:
        message = _handleStatusCode(dioError.response?.statusCode);
      case DioExceptionType.connectionError:
        message = 'No Internet.';
      case DioExceptionType.unknown:
        message = 'Unexpected error occurred.';
      case DioExceptionType.badCertificate:
        message = 'Bad Certificate';
    }
  }

  /// Static method for message of the error
  static late String message;

  static String _handleStatusCode(int? statusCode) {
    return switch (statusCode) {
      null => 'null',
      400 => 'Bad request.',
      401 => 'Authentication failed.',
      403 => 'The authenticated user is not allowed to access the endpoint.',
      404 => 'The requested resource does not exist.',
      405 => 'Method not allowed. ',
      415 => 'Unsupported media type.',
      422 => 'Data validation failed.',
      429 => 'Too many requests.',
      500 => 'Internal server error.',
      _ => 'Oops something went wrong!',
    };
  }
}
