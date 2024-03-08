import 'package:cailueedu/base/vm/base_view_model.dart';
import 'package:cailueedu/base/vm/view_model_state.dart';
import 'package:cailueedu/common/common_widget.dart';
import 'package:cailueedu/common/empty_widget.dart';
import 'package:cailueedu/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BasePage<T extends BaseViewModel> extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  final String? tag = null;

  T get viewModel => GetInstance().find<T>(tag: tag);

  @override
  StatelessElement createElement() {
    initViewModel();
    return super.createElement();
  }

  ///可以选择重写 初始化ViewModel， 如果已经初始化过可以不必重写
  ///example: Get.lazyPut<TestViewModel>(() => TestViewModel());
  void initViewModel() {}

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(builder: (cxt) {
      return Scaffold(
        appBar: _createAppBar(context),
        body: _buildBody(context),
        bottomNavigationBar: bottomNavigationBar(),
        resizeToAvoidBottomInset: false,
      );
    });
  }

  ///AppBar生成逻辑
  CommonAppBar? _createAppBar(BuildContext context) {
    if (showTitleBar()) {
      return CommonAppBar(
          title: titleString(),
          backOffstage: showBackButton(),
          actionWidget: createActionList());
    } else {
      return null;
    }
  }

  ///构建Tab

  Widget? bottomNavigationBar() {
    return null;
  }

  ///构建Scaffold-body主体内容
  Widget _buildBody(BuildContext context) {
    if (viewModel.modelState == ModelState.idle ||
        viewModel.modelState == ModelState.busy) {
      return buildContent(context);
    } else {
      late String emptyIconName;
      late String errorMsg;
      switch (viewModel.modelState) {
        case ModelState.empty:
          emptyIconName = "icon_nodata.png".intoImgEmptyPath();
          errorMsg = "暂无数据~";
          break;
        case ModelState.notNet:
          emptyIconName = "icon_nonet.png".intoImgEmptyPath();
          errorMsg = "网络错误 请重新再试";
          break;
        case ModelState.error:
          emptyIconName = "icon_load_error.png".intoImgEmptyPath();
          errorMsg = "加载失败 请重新再试";
          break;
        default:
          emptyIconName = "icon_nodata.png".intoImgEmptyPath();
          errorMsg = "暂无数据~";
          break;
      }
      return EmptyPageWidget(
          emptyIconName: emptyIconName,
          emptyStr: errorMsg,
          tapAction: () => loadAgain());
    }
  }

  ///加载失败需要重新加载时必须实现
 void loadAgain() {}

  ///是否展示titleBar标题栏
  bool showTitleBar() => true;

  ///是否展示回退按钮
  bool showBackButton() => true;

  ///showSuccess展示成功的布局
  Widget buildContent(BuildContext context);

  ///页面标题设置
  String titleString() => "";
  List<Widget> createActionList() => [];
}
