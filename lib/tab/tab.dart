import 'package:cailueedu/base/widget/base_page.dart';
import 'package:cailueedu/tab/tab_view_model.dart';
import 'package:cailueedu/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabPage extends BasePage<TabViewModel> {
  const TabPage({super.key});
  @override
  bool showTitleBar() {
    return false;
  }

  @override
  void initViewModel() {
    super.initViewModel();
    Get.put(TabViewModel());
  }

  @override
  Widget buildContent(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: viewModel.pageController,
      children: viewModel.pageList,
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        items: viewModel.bottomBarItems(),
        backgroundColor: Colors.white,
        currentIndex: viewModel.currentIndex.value,
        onTap: (index) {
          viewModel.changePage(index);
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          color: mainColor,
        ),
        unselectedLabelStyle:
            const TextStyle(color: k333Color, fontSize: 12),
        type: BottomNavigationBarType.fixed,
        fixedColor: mainColor,
      ),
    );
  }
}
