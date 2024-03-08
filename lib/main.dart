import 'package:cailueedu/common/app_config.dart';
import 'package:flutter/material.dart';
import 'app.dart';
Future<void> main() async {
  await AppConfig.appInit();
  runApp(const MyApp());
}
