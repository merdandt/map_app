// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart'
    show Interceptor, RequestInterceptorHandler, RequestOptions;

///
class LocalesInterceptor extends Interceptor {
  ///
  const LocalesInterceptor(
    this.localCode,
  );
  final String localCode;

  /// Satic field that defines if local code
  /// has to be sended in the header
  static const needLocal = 'requiresLocal';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // make this optional only if header has 'needLocal'
    if (options.headers.containsKey(needLocal)) {
      // get the current local_code.translation in order to
      // pass codes like: 'ru', 'tm' or 'en'
      options.headers['Accept-Language'] = localCode;
    }
    super.onRequest(options, handler);
  }
}
