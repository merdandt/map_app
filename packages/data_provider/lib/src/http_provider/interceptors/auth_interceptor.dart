import 'package:data_provider/data_provider.dart';
import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

///
class AuthTokenInterceptor extends Interceptor {
  ///
  const AuthTokenInterceptor();

  /// Static field that defines the if the token
  /// has to be sended or not
  static const needAuth = 'requiresToken';
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // make this optional only if header has 'needAuth'
    if (options.headers.containsKey(needAuth)) {
      //remove the auxiliary header
      options.headers.remove(needAuth);
      const storage = SecureStorage();
      // TODO: handle separate token storage
      final token = await storage.read(key: StorageKeys.accessToken);
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
