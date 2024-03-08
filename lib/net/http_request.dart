import 'dart:async';
import 'dart:convert';
import 'package:cailueedu/base/vm/view_model_state.dart';
import 'package:cailueedu/log/logger.dart';
import 'package:cailueedu/net/app_except.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<T> httpRequest<T>(Future<T> future,
    {Function(ModelState state)? state,
    bool showLoading = true,
    bool showToast = true}) {
  if (showLoading) {
    SmartDialog.showLoading();
  }
  if (state != null) {
    state(ModelState.busy);
  }
  future.then((t) {
    if (state != null) {
      if (t == null || (t is List && t.isEmpty)) {
        state(ModelState.empty);
      } else {
        state(ModelState.idle);
      }
    }
  }).catchError((e) async {
    AppException error = e.error as AppException;
    if (showToast) {
      SmartDialog.showToast(error.message ?? "请求失败");
    }
    if (error.code == 401) {
      // TODO:处理登录
      Logger.e("message");
    }
    if (state != null) {
      try {
        var connectivityResult = await Connectivity().checkConnectivity();
        state(connectivityResult == ConnectivityResult.none
            ? ModelState.notNet
            : ModelState.error);
      }  catch (e) {
        state(ModelState.notNet);
      }
    }
  }).whenComplete(() {
    if (showLoading) {
      SmartDialog.dismiss();
    }
  });
  return future;
}

Map createMap(Response? response) {
  Map dataMap = {};
  if (response?.data is Map) {
    dataMap = response?.data;
  } else if (response?.data is String) {
    dataMap = jsonDecode(response?.data);
  }
  return dataMap;
}
