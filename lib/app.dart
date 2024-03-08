import 'package:cailueedu/base/extend/widget_ext.dart';
import 'package:cailueedu/login/page/login_page.dart';
import 'package:cailueedu/router/router.dart';
import 'package:cailueedu/tab/tab.dart';
import 'package:cailueedu/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          defaultTransition: Transition.rightToLeft,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('zh', 'CN'),
            Locale('en', 'US'),
          ],
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            return locale;
          },
          debugShowCheckedModeBanner: false,
          title: '财华仁和会计',
          theme: ThemeData(
            primaryColor: Colors.white,
            platform: TargetPlatform.android,
            scaffoldBackgroundColor: Colors.white,
          ),
          home:
              child?.intoGestureDetector(onTap: () => hiddenKeyboard(context)),
          getPages: AppRoutes.routerPages,
          builder: FlutterSmartDialog.init(),
          navigatorObservers: [FlutterSmartDialog.observer],
        );
      },
      child: homePage(),
    );
  }

  Widget homePage() {
    String sessionId = SPUtils().get(kSessionId) ?? "";
    return sessionId.isNotEmpty ? const TabPage() : const LoginPage();
  }
}
void hiddenKeyboard(context) {

  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
