import 'package:cailueedu/base/extend/widget_ext.dart';
import 'package:cailueedu/utils/color_utils.dart';
import 'package:cailueedu/utils/fontsize_utils.dart';
import 'package:flutter/material.dart';

/// 空布局
class EmptyPageWidget extends StatelessWidget {
  final String emptyStr;
  final String emptyIconName;
  final Function? tapAction;
  final double bottomSpace;
  const EmptyPageWidget(
      {super.key,
      this.emptyStr = '暂无数据哦~',
      this.tapAction,
      this.bottomSpace = 200,
      required this.emptyIconName});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(bottom: bottomSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage(emptyIconName), width: 200, height: 200),
          Text(emptyStr,
              style: const TextStyle(
                color: k999Color,
                fontSize: FontSizeUtils.littleTextSize,
              )),
          Container(
            margin: const EdgeInsets.only(top: 30),
            width: 72,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(4)),
            child: const Text('重试',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSizeUtils.littleTextSize,
                )),
          ).intoGestureDetector(onTap: () {
            if (tapAction != null) {
              tapAction!();
            }
          }),
        ],
      ),
    );
  }
}
