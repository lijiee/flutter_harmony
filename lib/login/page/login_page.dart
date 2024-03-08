import 'package:cailueedu/base/extend/widget_ext.dart';
import 'package:cailueedu/base/widget/base_page.dart';
import 'package:cailueedu/common/common_widget.dart';
import 'package:cailueedu/login/vm/login_view_model.dart';
import 'package:cailueedu/net/api_const.dart';
import 'package:cailueedu/router/router.dart';
import 'package:cailueedu/utils/color_utils.dart';
import 'package:cailueedu/utils/image_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends BasePage<LoginViewModel> {
  const LoginPage({Key? key}) : super(key: key);
  @override
  void initViewModel() {
    super.initViewModel();
    Get.put(LoginViewModel());
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        _buildTopImage(),
        _buildSelectWidget(),
        buildTextField(
          viewModel.phoneEditController,
          viewModel.phoneFocusNode,
          "请输入手机号",
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(11)
          ],
          keyboardType: TextInputType.phone,
          deleteAction: () {
            viewModel.phoneEditController.text = "";
            viewModel.notifyListeners();
          },
        ),
        Obx(
          () => buildTextField(
            viewModel.passEditController,
            viewModel.passFocusNode,
            viewModel.index.value == 0 ? "请输入密码" : "请输入验证码",
            keyboardType: viewModel.index.value == 0
                ? TextInputType.text
                : TextInputType.phone,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(
                  viewModel.index.value == 0 ? 16 : 6)
            ], //限制长度
            isPass: viewModel.index.value == 0,
            deleteAction: () {
              viewModel.passEditController.text = "";
              viewModel.notifyListeners();
            },
            obscureText: viewModel.obscureText.value,
            showAction: () => viewModel.changeShow(),
            child: viewModel.index.value == 0
                ? null
                : Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      viewModel.count.value == 0
                          ? "获取验证码"
                          : ("(${viewModel.count.value.toString()}ss后重新发送)"),
                      style: TextStyle(
                          color: viewModel.count.value == 0
                              ? mainColor
                              : k666Color,
                          fontSize: 14.sp),
                    ).intoInkWell(
                      onTap: viewModel.count.value == 0 ? () {} : null,
                    ),
                  ),
          ),
        ),
        _buildLoginButton(),
        _buildBottom(),
        const Spacer(),
        _buildCheckWidget(),
      ],
    );
  }

  _buildTopImage() {
    return Image.asset(
      "icon_login_banner.png".intoImgLoginPath(),
      width: Get.width,
      fit: BoxFit.fill,
    ).onTap(() {
      if (ApiConst.isDebug) {
        Get.toNamed(AppRoutes.envPage);
      }
    });
  }

  _buildSelectWidget() {
    return Obx(() => Row(
          children: [
            Text(
              "密码登录",
              style: TextStyle(
                color: viewModel.index.value == 0 ? k333Color : k999Color,
                fontSize: viewModel.index.value == 0 ? 22.sp : 18.sp,
                fontWeight: viewModel.index.value == 0
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            )
                .paddingOnly(left: 16.w, right: 24.w)
                .onTap(() => viewModel.changeSelect(0)),
            Text(
              "验证码登录",
              style: TextStyle(
                color: viewModel.index.value == 1 ? k333Color : k999Color,
                fontSize: viewModel.index.value == 1 ? 22.sp : 18.sp,
                fontWeight: viewModel.index.value == 1
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ).onTap(() => viewModel.changeSelect(1)),
          ],
        ).paddingOnly(
          top: 20.h,
          bottom: 20.h,
        ));
  }

  _buildLoginButton() {
    return TextButton(
      onPressed: () => viewModel.loginAction(),
      child: Text(
        "登录",
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
    ).intoContainer(
      width: Get.width - 32.w,
      margin: EdgeInsets.only(top: 30.h),
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.h), // 设置圆角半径
        color: mainColor, // 设置按钮颜色
      ),
    );
  }

  _buildBottom() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "忘记密码",
            style: TextStyle(color: k999Color, fontSize: 14.sp),
          ).intoOffstage(offstage: viewModel.index.value == 1),
          Text(
            "未注册手机登录后自动注册",
            style: TextStyle(color: k999Color, fontSize: 14.sp),
          ).intoOffstage(offstage: viewModel.index.value == 0),
          Text(
            "注册新用户",
            style: TextStyle(color: mainColor, fontSize: 14.sp),
          ).intoOffstage(offstage: viewModel.index.value == 1),
        ],
      ).paddingOnly(top: 20.h, left: 16.w, right: 16.w),
    );
  }

  _buildCheckWidget() {
    return Obx(
      () => Offstage(
        offstage: viewModel.index.value == 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              viewModel.selectCheck.value == false
                  ? Icons.check_box_outline_blank_rounded
                  : Icons.check_box_outlined,
              color:
                  viewModel.selectCheck.value == false ? k999Color : mainColor,
              size: 15.h,
            ).onTap(() => viewModel.changeCheck()),
            SizedBox(width: 5.w),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "登录即代表您同意财华仁和会计",
                  style: TextStyle(color: k999Color, fontSize: 10.sp),
                  children: [
                    TextSpan(
                      text: "《用户协议》",
                      style: TextStyle(color: mainColor, fontSize: 10.sp),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoutes.webPage, arguments: {
                            "title": "用户协议",
                            "url": ApiConst.agreementUrl
                          });
                        },
                    ),
                    TextSpan(
                      text: "和",
                      style: TextStyle(color: k999Color, fontSize: 10.sp),
                    ),
                    TextSpan(
                      text: "《隐私政策》",
                      style: TextStyle(color: mainColor, fontSize: 10.sp),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoutes.webPage, arguments: {
                            "title": "隐私政策",
                            "url": ApiConst.policyUrl
                          });
                        },
                    ),
                  ]),
            ).intoContainer(
              height: 15.h,
              alignment: Alignment.center,
            ),
          ],
        ).paddingOnly(bottom: 20.h),
      ),
    );
  }

  @override
  bool showTitleBar() {
    return false;
  }
}
