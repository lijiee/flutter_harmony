import 'package:cailueedu/base/extend/widget_ext.dart';
import 'package:cailueedu/base/widget/base_page.dart';
import 'package:cailueedu/home/vm/home_view_model.dart';
import 'package:cailueedu/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends BasePage<HomeViewModel> {
  const HomePage({Key? key}) : super(key: key);
  @override
  void initViewModel() {
    super.initViewModel();
    Get.put(HomeViewModel());
  }

  @override
  Widget buildContent(BuildContext context) {
    return const Text("点击")
        .intoCenter()
        .intoGestureDetector(onTap: () => {
          Get.toNamed(AppRoutes.envPage)
    });
  }

  @override
  String titleString() {
    return "首页";
  }

  @override
  bool showBackButton() {
    return false;
  }
  @override
  loadAgain() {

  }
}
