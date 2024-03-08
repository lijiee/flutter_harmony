import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///***********************************************///
/// Name:      RefresherFooter
/// Desc:      刷新头部UI
/// Author:    lijiee
/// Date:      2022/8/12 14:13
///**********************************************///

class RefresherFooter extends StatelessWidget {
  const RefresherFooter({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const ClassicFooter(
      failedText: CNRefreshString.loadFailedText,
      idleText: CNRefreshString.idleLoadingText,
      loadingText: CNRefreshString.loadingText,
      noDataText: CNRefreshString.noMoreText,
    );
  }
}

///***********************************************///
/// Name:      RefresherHeader
/// Desc:      刷新底部UI
/// Author:    lijiee
/// Date:      2022/8/12 14:13
///**********************************************///

class RefresherHeader extends StatelessWidget {
  const RefresherHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const ClassicHeader(
      releaseText: CNRefreshString.canRefreshText,
      refreshingText: CNRefreshString.refreshingText,
      canTwoLevelText: CNRefreshString.canTwoLevelText,
      completeText: CNRefreshString.refreshCompleteText,
      failedText: CNRefreshString.refreshFailedText,
      idleText: CNRefreshString.idleRefreshText,
    );
  }
}

///***********************************************///
/// Name:      CNRefreshString
/// Desc:      刷新中文设置
/// Author:    lijiee
/// Date:      2022/8/12 14:14
///**********************************************///

class CNRefreshString {
  static const String canLoadingText = "松手开始加载数据";

  static const String canRefreshText = "松开开始刷新数据";

  static const String canTwoLevelText = "释放手势,进入二楼";

  static const String idleLoadingText = "上拉加载";

  static const String idleRefreshText = "下拉刷新";

  static const String loadFailedText = "加载失败";

  static const String loadingText = "加载中…";

  static const String noMoreText = "没有更多数据了";

  static const String refreshCompleteText = "刷新成功";

  static const String refreshFailedText = "刷新失败";

  static const String refreshingText = "刷新中…";
}
