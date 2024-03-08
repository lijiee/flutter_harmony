import 'package:cailueedu/login/entity/sign_entity.dart';
import 'package:cailueedu/net/api_const.dart';
import 'package:cailueedu/net/dio_client.dart';
import 'package:cailueedu/net/dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService({Dio? dio, String? baseUrl}) {
    DioClient dioClient = DioClient.initClient(
        interceptors: [DioInterceptor()], baseUrl: baseUrl ?? ApiConst.baseUrl);
    dio ??= dioClient.dio;
    return _ApiService(dio, baseUrl: baseUrl);
  }
  @FormUrlEncoded()
  @POST("api/user/getKeyMap")
  Future<SignEntity> queryKeyMap();

  @FormUrlEncoded()
  @POST("api/qa/commonQuestion/getCommonQuestionTypeList")
  Future<List<SignEntity>> getCommonQuestionTypeList();

  @FormUrlEncoded()
  @POST("api/op/countReceiveAffiche")
  Future<int> countReceiveAffiche(@Body() Map<String, dynamic> map);

  @FormUrlEncoded()
  @POST("api/user/login")
  Future<int?> userLogin(@Body() Map<String, dynamic> map);

}
