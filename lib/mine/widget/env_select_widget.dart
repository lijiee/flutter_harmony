import 'package:cailueedu/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnvSelectWidget extends StatelessWidget {
  final List<String> list;
  final String selectStr;
  final Function? tapAction;
  const EnvSelectWidget(
      {Key? key, this.tapAction, required this.list, required this.selectStr})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 400.h,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(list[index]),
                trailing: selectStr == list[index]
                    ? const Icon(
                        Icons.check,
                        color: mainColor,
                      )
                    : null,
                onTap: () {
                  if (tapAction != null) {
                    tapAction!(list[index]);
                  }
                },
              ),
              const Divider(
                height: 1,
                color: kF5Color,
              ),
            ],
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
