import 'package:data_provider/data_provider.dart';

/// {@template dio_client}
/// Http client for handling remote API
/// {@endtemplate}
class ApiClient {
  /// {@macro dio_client}
  ApiClient({
    String localCode = 'en',
    String baseUrl = APIEdnPoints.baseUrl,
  }) : client = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 4),
            receiveTimeout: const Duration(seconds: 2),
          ),
        )..interceptors.addAll([
            LogInterceptor(),
            LocalesInterceptor(localCode),
            const AuthTokenInterceptor(),
            QueuedInterceptor()
          ]);

  /// Dio client as http client
  late final Dio client;
}
