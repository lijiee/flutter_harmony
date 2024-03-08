import 'package:cailueedu/base/extend/widget_ext.dart';
import 'package:cailueedu/base/widget/base_page.dart';
import 'package:cailueedu/mine/vm/mine_view_model.dart';
import 'package:cailueedu/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class MinePage extends BasePage<MineViewModel> {
  const MinePage({Key? key}) : super(key: key);
  @override
  void initViewModel() {
    super.initViewModel();
    Get.put(MineViewModel());
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
    return "我的";
  }

  @override
  bool showBackButton() {
    return false;
  }
  @override
  loadAgain() {

  }
}
