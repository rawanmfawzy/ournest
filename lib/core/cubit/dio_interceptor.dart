import 'package:dio/dio.dart';
import 'token_storage_helper.dart';
import '../../features/auth/services/login_service.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:5038/api",
    ),
  );

  static void init() {
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
          if (error.response?.statusCode == 401) {
            try {
              final token = await TokenStorage.getToken();
              final refresh = await TokenStorage.getRefreshToken();

              if (token == null || refresh == null) {
                await TokenStorage.clear();
                return handler.next(error);
              }

              final newToken = await LoginService.refreshToken(
                token,
                refresh,
              );

              await TokenStorage.saveToken(newToken["token"]);

              error.requestOptions.headers["Authorization"] =
              "Bearer ${newToken["token"]}";

              final response = await dio.fetch(error.requestOptions);

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
}