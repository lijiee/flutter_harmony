import 'dart:math';

import 'package:flutter/material.dart';

const Color mainColor = Color(0xff2E7DFF);
const Color k333Color = Color(0xff333333);
const Color k666Color = Color(0xff666666);
const Color k999Color = Color(0xff999999);
const Color kEEEColor = Color(0xffEEEEEE);
const Color kCCCColor = Color(0xffCCCCCC);
const Color kFAColor = Color(0xffFAFAFA);
const Color kF8Color = Color(0xffF8F8F8);
const Color kF5Color = Color(0xffF5F5F5);

class ColorUtils {
  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexIntColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }

  static Color hexColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // 取随机颜色
  static Color randomColor() {
    var red = Random.secure().nextInt(255);
    var greed = Random.secure().nextInt(255);
    var blue = Random.secure().nextInt(255);
    return Color.fromARGB(255, red, greed, blue);
  }
}
