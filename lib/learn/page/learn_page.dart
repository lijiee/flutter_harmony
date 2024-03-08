import 'package:cailueedu/base/extend/widget_ext.dart';
import 'package:cailueedu/base/widget/base_page.dart';
import 'package:cailueedu/home/vm/home_view_model.dart';
import 'package:cailueedu/learn/vm/learn_view_model.dart';
import 'package:cailueedu/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearnPage extends BasePage<LearnViewModel> {
  const LearnPage({Key? key}) : super(key: key);
  @override
  void initViewModel() {
    super.initViewModel();
    Get.put(LearnViewModel());
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
    return "学习";
  }

  @override
  bool showBackButton() {
    return false;
  }
  @override
  loadAgain() {

  }
}
