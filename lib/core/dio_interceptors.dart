import 'package:dio/dio.dart';

int retryCount = 0;

class DioInterceptors {
  DioInterceptors(this._dioClient) {
    _addInterceptors();
  }

  final Dio _dioClient;

  void _addInterceptors() {
    _dioClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.validateStatus = (status) => status! < 1000;
          options.headers['Content-Type'] = 'application/json';
          options.headers['accept'] = 'application/json';

          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
      ),
    );
  }

  Dio get dioWithInterceptors => _dioClient;
}
