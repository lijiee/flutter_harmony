import 'dart:io';
import 'package:cailueedu/log/logger.dart';
import 'package:cailueedu/net/api_const.dart';
import 'package:cailueedu/net/api_nouyi_service.dart';
import 'package:cailueedu/net/api_service.dart';
import 'package:cailueedu/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class AppConfig {
  static Future<void> appInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    await SPUtils.perInit();
    Logger.init(true);
    await serviceInit();
    SmartConfigToast(alignment: Alignment.center);
  }
  ///应用的服务的初始化，比如SP， DB etc
  static Future<void> serviceInit() async {
    Logger.d("serviceInit");
    Get.lazyPut(() => ApiService(baseUrl: ApiConst.baseUrl), fenix: true);
    Get.lazyPut(() => ApiNouYiService(baseUrl: ApiConst.nouYiUrl), fenix: true);
  }
}
