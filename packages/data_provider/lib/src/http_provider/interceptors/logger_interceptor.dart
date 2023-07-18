import 'dart:developer' as devtools show log;

import 'package:dio/dio.dart'
    show
        DioException,
        ErrorInterceptorHandler,
        Interceptor,
        RequestInterceptorHandler,
        RequestOptions,
        Response,
        ResponseInterceptorHandler;

/// Extentions for log the object
extension Log on Object {
  /// Function for called on object
  void log() => devtools.log(toString());
}

///
class LoggerInterceptor extends Interceptor {
  String _pathURL(RequestOptions options) =>
      '${options.baseUrl}${options.path}';

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final path = _pathURL(options);
    'ERROR ############# - ${options.method} on $path'.log();
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final path = _pathURL(options);
    '<- <- <- <- <-: ${options.method} to $path'.log();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final path = _pathURL(response.requestOptions);
    '-> -> -> -> ->: ${response.statusCode}, to '
            '$path \n ------data------ ${response.data} \n ----------'
        .log();
    super.onResponse(response, handler);
  }
}
