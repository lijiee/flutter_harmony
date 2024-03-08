import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_view_model.dart';

///***********************************************///
/// Name:      BaseRefreshViewModel
/// Desc:      支持下拉刷新
/// Author:    lijiee
/// Date:      2022/8/12 14:12
///**********************************************///

abstract class BaseRefreshViewModel<T> extends BaseViewModel {
  /// 页面数据
  T? data;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;
  initData() async {
    setBusy();
    doRefresh(init: true);
  }

  // 下拉刷新
  doRefresh({bool init = false}) async {
    try {
      T data = await loadData();
      refreshController.refreshCompleted();
      onCompleted(data);
    } catch (e, s) {
      if (init) {}
      refreshController.refreshFailed();
      onCompleted(null);
    }
  }

  // 加载数据
  Future<T> loadData();

  // 数据完成时候调用
  onCompleted(T? data) {}
}
