import 'package:cailueedu/login/page/login_page.dart';
import 'package:cailueedu/login/page/web_page.dart';
import 'package:cailueedu/mine/page/env_page.dart';
import 'package:cailueedu/tab/tab.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const tabPage = "/tab";
  static const envPage = "/mine/env";
  static const loginPage = "/login";
  static const webPage = "/web";
  static final routerPages = [
    ///主入口
    GetPage(name: AppRoutes.tabPage, page: () => const TabPage()),
    ///环境切换
    GetPage(name: AppRoutes.envPage, page: () => const EnvPage()),
    ///环境切换
    GetPage(name: AppRoutes.loginPage, page: () => const LoginPage()),
    ///网页
    GetPage(name: AppRoutes.webPage, page: ()=> const WebPage())
  ];
}
