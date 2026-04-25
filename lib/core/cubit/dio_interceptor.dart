import 'package:dio/dio.dart';
import 'token_storage_helper.dart';
import '../../features/auth/services/login_service.dart';
class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:5038/api",
      contentType: "application/json",
    ),
  );

  static bool _initialized = false;

  static void init() {
    if (_initialized) return;
    _initialized = true;

    dio.interceptors.clear();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onError: (error, handler) async {
          final statusCode = error.response?.statusCode;

          if (statusCode == 401 &&
              error.requestOptions.extra["retry"] != true) {
            try {
              final token = await TokenStorage.getToken();
              final refresh = await TokenStorage.getRefreshToken();

              if (token == null || refresh == null) {
                await TokenStorage.clear();
                return handler.next(error);
              }

              final newToken =
              await LoginService.refreshToken(token, refresh);

              final accessToken = newToken["token"]?.toString();

              if (accessToken == null) {
                await TokenStorage.clear();
                return handler.next(error);
              }

              await TokenStorage.saveToken(accessToken);

              final opts = error.requestOptions;
              opts.headers["Authorization"] = "Bearer $accessToken";
              opts.extra["retry"] = true;

              final response = await dio.request(
                opts.path,
                data: opts.data,
                queryParameters: opts.queryParameters,
                options: Options(
                  method: opts.method,
                  headers: opts.headers,
                  contentType: opts.contentType,
                  responseType: opts.responseType,
                ),
              );

              return handler.resolve(response);
            } catch (e) {
              await TokenStorage.clear();
              return handler.next(error);
            }
          }

          return handler.next(error);
        },
      ),
    );
  }
  static Future<void> setToken() async {
    final token = await TokenStorage.getToken();

    if (token != null) {
      dio.options.headers["Authorization"] = "Bearer $token";
    }
  }
}