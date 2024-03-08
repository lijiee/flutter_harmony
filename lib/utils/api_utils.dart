import 'package:cailueedu/net/api_nouyi_service.dart';
import 'package:cailueedu/net/api_service.dart';
import 'package:get/get.dart';

class ApiUtils {
  static final ApiUtils _instance = ApiUtils._internal();
  factory ApiUtils() {
    return _instance;
  }
  ApiUtils._internal();

  ApiService serviceApi() {
    late ApiService api;
    try {
      api = Get.find<ApiService>();
    } catch (e) {
      api = ApiService();
      Get.put(api);
    }
    return api;
  }

  ApiNouYiService serviceNouYiApi() {
    late ApiNouYiService api;
    try {
      api = Get.find<ApiNouYiService>();
    } catch (e) {
      api = ApiNouYiService();
      Get.put(api);
    }
    return api;
  }
}
