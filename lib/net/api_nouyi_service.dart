import 'package:cailueedu/home/entity/version_check_entity.dart';
import 'package:cailueedu/net/api_const.dart';
import 'package:cailueedu/net/dio_client.dart';
import 'package:cailueedu/net/dio_nouyi_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'api_nouyi_service.g.dart';

@RestApi()
abstract class ApiNouYiService {
  factory ApiNouYiService({Dio? dio, String? baseUrl}) {
    DioClient dioClient = DioClient.initClient(
        interceptors: [DioNouYiInterceptor()],
        baseUrl: baseUrl ?? ApiConst.nouYiUrl);
    dio ??= dioClient.dio;
    return _ApiNouYiService(dio, baseUrl: baseUrl);
  }
  @POST("system/appVersion/getLastVersion")
  Future<VersionCheckEntity> getLastVersion(@Body() Map<String, dynamic> map);

  @POST("/app/recite/list")
  Future<List<VersionCheckEntity>> reciteList();
}
