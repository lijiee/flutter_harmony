import 'dart:convert';
import 'dart:io';
import 'package:cailueedu/base/vm/base_view_model.dart';
import 'package:cailueedu/mine/widget/env_select_widget.dart';
import 'package:cailueedu/net/api_const.dart';
import 'package:cailueedu/utils/sp_utils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EnvViewModel extends BaseViewModel {
  String baseUrl = ApiConst.baseUrl;
  String nouYiUrl = ApiConst.nouYiUrl;
  String h5Url = ApiConst.h5Url;
  List<String> baseList = [];
  List<String> nuoYiList = [];
  List<String> h5List = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    String config =
        await rootBundle.loadString("assets/data/build_config.json");
    Map<String, dynamic> map = json.decode(config);
    baseList =
        (map["baseUrl"] as List<dynamic>).map((e) => e.toString()).toList();
    h5List = (map["h5Url"] as List<dynamic>).map((e) => e.toString()).toList();
    nuoYiList =
        (map["nouYiUrl"] as List<dynamic>).map((e) => e.toString()).toList();
  }

  onTap(int tag) {
    List<String> list = [];
    String selectStr = "";
    switch (tag) {
      case 1:
        selectStr = baseUrl;
        list = baseList;
        break;
      case 2:
        selectStr = nouYiUrl;
        list = nuoYiList;
        break;
      case 3:
        selectStr = h5Url;
        list = h5List;
        break;
    }
    Get.bottomSheet(EnvSelectWidget(
      list: list,
      selectStr: selectStr,
      tapAction: (value) {
        switch (tag) {
          case 1:
            baseUrl = value;
            break;
          case 2:
            nouYiUrl = value;
            break;
          case 3:
            h5Url = value;
            break;
        }
        Get.back();
        notifyListeners();
      },
    ));
  }

  onSure() {
    SPUtils().setString(kBaseUrl, baseUrl);
    SPUtils().setString(kH5Url, h5Url);
    SPUtils().setString(kNouYiUrl, nouYiUrl);
    exit(1);
  }
}
