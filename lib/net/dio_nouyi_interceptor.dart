import 'package:cailueedu/log/logger.dart';
import 'package:cailueedu/net/app_except.dart';
import 'package:cailueedu/net/http_request.dart';
import 'package:dio/dio.dart';

class DioNouYiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers = {"Content-Type": "application/json"};
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map dataMap = createMap(response);
    if (dataMap.isEmpty) {
      dataMap = {'code': 200, 'data': {}, 'msg': 'success'};
    }
    if (dataMap['code'] != 200 || dataMap["code"] != 0) {
      handler.reject(
        DioException.badResponse(
            statusCode: dataMap["code"],
            requestOptions: response.requestOptions,
            response: response),
        true,
      );
      return;
    }
    if (!dataMap.keys.contains("data")) {
      dataMap["data"] = {};
    }
    response.data = dataMap['data'];
    handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    Map dataMap = createMap(err.response);
    if ((dataMap.keys.contains("msg")) && dataMap.keys.contains("code")) {
      AppException appException = AppException(dataMap["code"], dataMap["msg"]);
      DioException dioException =
          DioException(requestOptions: err.requestOptions, error: appException);
      handler.reject(dioException);
      return;
    }
    AppException appException = AppException.create(err);
    DioException dioException =
        DioException(requestOptions: err.requestOptions, error: appException);
    handler.reject(dioException);
  }
}
