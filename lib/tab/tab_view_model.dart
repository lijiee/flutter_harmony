import 'package:cailueedu/base/vm/base_view_model.dart';
import 'package:cailueedu/home/page/home_page.dart';
import 'package:cailueedu/learn/page/learn_page.dart';
import 'package:cailueedu/mine/page/mine_page.dart';
import 'package:cailueedu/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabViewModel extends BaseViewModel {
  final PageController pageController = PageController();
  final List<Widget> pageList = [
    const HomePage(),
    const LearnPage(),
    const MinePage()
  ];
  RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  List<BottomNavigationBarItem> bottomBarItems() {
    return [
      _createBottomBarItem("icon_home", "首页"),
      _createBottomBarItem("icon_learn", "学习"),
      _createBottomBarItem("icon_mine", "我的"),
    ];
  }

  BottomNavigationBarItem _createBottomBarItem(String imageName, String label) {
    return BottomNavigationBarItem(
        icon: Image.asset(("$imageName.png").intoImgTabPath(),
            width: 24, height: 24),
        label: label,
        activeIcon: Image.asset(("${imageName}_select.png").intoImgTabPath(),
            width: 24, height: 24));
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
