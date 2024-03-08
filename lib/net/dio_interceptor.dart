import 'dart:convert';
import 'package:cailueedu/log/logger.dart';
import 'package:cailueedu/net/api_const.dart';
import 'package:cailueedu/net/app_except.dart';
import 'package:cailueedu/net/http_request.dart';
import 'package:cailueedu/utils/sp_utils.dart';
import 'package:cailueedu/utils/time_utils.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class DioInterceptor extends Interceptor {
  static const String privateKey =
      "vuPgVevkiM7AnzuyjrKYihIGLmFLfk8Fxc8IX3QJtZJc6UUddutOHCOIebZxCK8L";
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers = {"Content-Type": "application/x-www-form-urlencoded"};
    Map<String, dynamic> map = {
      "privateKey": privateKey,
      "version": ApiConst.versionName,
      "timestamps": TimeUtil.getTime(null)
    };
    String? sessionId = SPUtils().get(kSessionId);
    if (options.data != null) {
      var data = options.data as Map<String, dynamic>;
      map.addAll(data);
    }
    if (sessionId?.isNotEmpty ?? false) {
      map["token"] = sessionId;
    }
    map["sign"] = mapToMd5(map);
    options.data = map;
    super.onRequest(options, handler);
  }

  String mapToMd5(Map<String, dynamic> data) {
    List<MapEntry<String, dynamic>> sortedEntries = data.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    String joinedString =
        sortedEntries.map((entry) => '${entry.key}|${entry.value}').join('|');
    String hashedString = md5.convert(utf8.encode(joinedString)).toString();
    return hashedString;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map dataMap = createMap(response);
    if (dataMap.isEmpty) {
      dataMap = {'success': true, 'entity': {}, 'message': 'success'};
    }
    if (dataMap['success'] == false) {
      handler.reject(
        DioException.badResponse(
            statusCode: 10,
            requestOptions: response.requestOptions,
            response: response),
        true,
      );
      return;
    }
    if (!dataMap.keys.contains("entity")) {
      dataMap["entity"] = {};
    }
    response.data = dataMap['entity'];
    handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    Map dataMap = createMap(err.response);
    if (dataMap.keys.contains("message")) {
      String message = dataMap["message"];
      int code = 10;
      if (dataMap.keys.contains("loginStatus")) {
        code = 401;
      }
      AppException appException = AppException(code, message);
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
