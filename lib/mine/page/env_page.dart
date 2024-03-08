import 'package:cailueedu/base/extend/widget_ext.dart';
import 'package:cailueedu/base/widget/base_page.dart';
import 'package:cailueedu/mine/vm/env_view_model.dart';
import 'package:cailueedu/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EnvPage extends BasePage<EnvViewModel> {
  const EnvPage({Key? key}) : super(key: key);
  @override
  void initViewModel() {
    super.initViewModel();
    Get.put(EnvViewModel());
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSingleWidget("网校:", viewModel.baseUrl)
            .onTap(() => viewModel.onTap(1)),
        _buildSingleWidget("诺依:", viewModel.nouYiUrl)
            .onTap(() => viewModel.onTap(2)),
        _buildSingleWidget("h5:", viewModel.h5Url)
            .onTap(() => viewModel.onTap(3)),
        TextButton(
          onPressed: () => viewModel.onSure(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return mainColor; // 默认的背景颜色
              },
            ),
          ),
          child: Text("确定",
              style: TextStyle(color: Colors.white, fontSize: 16.sp)),
        ).intoContainer(
            width: context.width - 40.w, padding: EdgeInsets.only(top: 40.h))
      ],
    );
  }

  Widget _buildSingleWidget(String name, String url) {
    return Row(
      children: [
        Text(name)
            .intoContainer(width: 65.w, padding: EdgeInsets.only(left: 20.w)),
        Text(
          url,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ).paddingOnly(right: 20.w).intoExpanded()
      ],
    ).intoContainer(height: 50.h);
  }

  @override
  String titleString() {
    return "环境切换";
  }
}
