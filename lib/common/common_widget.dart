import 'package:cailueedu/base/extend/widget_ext.dart';
import 'package:cailueedu/utils/color_utils.dart';
import 'package:cailueedu/utils/fontsize_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///***********************************************///
/// Name:      NetImageWidget
/// Desc:      网络加载图片
/// Author:    lijie01@thalys.net.cn
/// Date:      2021/6/3 1:41 PM
///**********************************************///

class NetImageWidget extends StatelessWidget {
  const NetImageWidget({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    this.borderRadius = 0,
    this.errorAsset = "assets/images/ic_avatar_default.png",
    this.boxFit = BoxFit.cover,
  });

  final String url;
  final double borderRadius;
  final String errorAsset;
  final double width;
  final double height;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    var errorHolder = Image.asset(
      errorAsset,
      width: width,
      height: height,
    );

    var placeHolder = SizedBox(
      width: width,
      height: height,
      child: const CircularProgressIndicator(
        backgroundColor: kF5Color,
        strokeWidth: 2,
      ),
    );
    if ((url.isBlank ?? false) || !url.contains("http")) {
      return errorHolder;
    }
    try {
      return Image.network(
        url,
        width: width,
        height: height,
        fit: boxFit,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          } else {
            return frame != null ? child : placeHolder;
          }
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return placeHolder;
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return errorHolder;
        },
      );
    } catch (e) {
      return errorHolder;
    }
  }
}

///***********************************************///
/// Name:      CommonAppBar
/// Desc:      通用导航
/// Author:    lijie01@thalys.net.cn
/// Date:      2021/6/3 1:41 PM
///**********************************************///
// ignore: must_be_immutable
class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? menu;
  final List<Widget>? actionWidget;
  final Function? goBack;
  final bool backOffstage; // 是否隐藏返回按钮

  const CommonAppBar(
      {super.key,
      required this.title,
      this.menu,
      this.actionWidget,
      this.backOffstage = false,
      this.goBack});

  @override
  State<StatefulWidget> createState() {
    return _CommonAppState();
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}

class _CommonAppState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          widget.title ?? "",
          style: const TextStyle(
            color: k333Color,
            fontSize: FontSizeUtils.titleTextSize,
          ),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            if (widget.goBack != null) {
              widget.goBack!();
            } else {
              Get.back();
            }
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: k333Color,
          ),
        ).intoOffstage(
          offstage: !widget.backOffstage,
        ),
        actions: widget.actionWidget);
  }
}

extension CommomWidget on StatelessWidget {
  Widget buildTextField(
    TextEditingController editingController,
    FocusNode focusNode,
    String hintText, {
    Function? deleteAction,
    bool? isPass,
    List<TextInputFormatter>? inputFormatters,
    Function? showAction,
    bool? obscureText,
    Widget? child,
    TextInputType? keyboardType,
  }) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 16.w, right: 16.w),
        // height: 44.h,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: kF5Color,
              width: 1.0,
            ),
          ),
        ),
        child: TextField(
            obscureText: (obscureText == true && isPass == true),
            controller: editingController,
            focusNode: focusNode,
            keyboardType: keyboardType,
            cursorColor: mainColor,
            maxLines: 1,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: k999Color, fontSize: 14.sp),
              hintText: hintText,
              border: InputBorder.none,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Offstage(
                    offstage: !(focusNode.hasFocus &&
                        editingController.text.isNotEmpty),
                    child: Icon(
                      Icons.cancel,
                      color: k333Color,
                      size: 20.w,
                    ).onTap(() {
                      if (deleteAction != null) {
                        deleteAction();
                      }
                    }),
                  ),
                  Offstage(
                    offstage: !(isPass ?? false),
                    child: Icon(
                      obscureText == true
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: k333Color,
                      size: 20.w,
                    ).onTap(() {
                      if (showAction != null) {
                        showAction();
                      }
                    }),
                  ),
                  child ?? const SizedBox(),
                ],
              ),
            ),
            style: TextStyle(color: k333Color, fontSize: 14.sp),
            inputFormatters: inputFormatters //限制长度
            ));
  }
}
