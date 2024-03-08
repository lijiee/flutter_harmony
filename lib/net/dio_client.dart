import 'dart:io';
import 'package:cailueedu/net/api_const.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

////Dio客户端
class DioClient {
  ///超时时间
  static const int connectTimeOut = 60;
  static const int receiveTimeOut = 60;

  static DioClient initClient({
    required String baseUrl,
    int connectTimeout = connectTimeOut,
    int receiveTimeout = receiveTimeOut,
    List<Interceptor>? interceptors,
  }) {
    DioClient dioClient = DioClient._internal();
    dioClient.init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      interceptors: interceptors,
    );
    return dioClient;
  }
  // 不能使用单利
  // static final DioClient _instance = DioClient._internal();
  //
  // factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: connectTimeOut),
      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: const Duration(seconds: receiveTimeOut),

      // Http请求头.
      headers: {},
    );

    dio = Dio(options);
    if ((ApiConst.proxyIP != "") &&
        (ApiConst.proxyPort != "") &&
        (ApiConst.proxyEnable == true)) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.findProxy = (uri) {
            return 'PROXY ${ApiConst.proxyIP}:${ApiConst.proxyPort}';
          };
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        },
      );
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init({
    String? baseUrl,
    int connectTimeout = receiveTimeOut,
    int receiveTimeout = connectTimeOut,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: receiveTimeOut),
      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: const Duration(seconds: receiveTimeOut),
      headers: headers ?? const {},
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }
}
