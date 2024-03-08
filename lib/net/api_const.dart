import 'package:cailueedu/utils/sp_utils.dart';

class ApiConst {
  ///APP 版本
  static int versionCode = 1;

  ///APP 版本名称
  static String versionName = "1.0.0";

  ///当前接口地址
  static String baseUrl =
      SPUtils().get(kBaseUrl) ?? "http://192.168.201.138:8888";

  static String nouYiUrl = SPUtils().get(kNouYiUrl) ??
      "http://192.168.201.138:8888";

  static String h5Url =
      SPUtils().get(kH5Url) ?? "http://192.168.201.138:8888";

  ///当前接口地址
  static bool proxyEnable = false;

  static String proxyIP = "192.168.201.138";

  static String proxyPort = "8888";

  static bool isDebug = true;

  static String policyUrl = "";

  static String agreementUrl = "";

}
