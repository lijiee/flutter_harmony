import 'package:cailueedu/base/vm/base_view_model.dart';
import 'package:cailueedu/log/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///***********************************************///
/// Name:      BaseRefreshListViewModel
/// Desc:      支持下拉刷新，上拉加载更多
/// Author:    lijiee
/// Date:      2022/8/12 14:11
///**********************************************///

abstract class BaseRefreshListViewModel<T> extends BaseViewModel {
  static const String tag = "[BaseRefreshListViewModel]";
  int pageSize = 20;
  int _curPage = 1;
  List<T>? list = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;

  initData() async {
    setBusy();
    await doRefresh();
  }

  Future<List<T>?> doRefresh() async {
    try {
      _curPage = 1;
      var data = await loadData(page: 1);
      Logger.d(data == null ? "data is null" : "data not null");
      if (data?.isEmpty ?? true) {
        refreshController.refreshCompleted(resetFooterState: true);
        list?.clear();
      } else {
        list?.clear();
        list?.addAll(data!);
        refreshController.refreshCompleted();
        // 小于分页的数量,禁止上拉加载更多
        if ((data?.length ?? 0) < pageSize) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
      }
      onCompleted(data);
      return data;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      list?.clear();
      refreshController.refreshFailed();
      onCompleted(null);
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<T>?> doLoadMore() async {
    try {
      var data = await loadData(page: ++_curPage);
      if (data?.isEmpty ?? true) {
        _curPage--;
        refreshController.loadNoData();
      } else {
        list?.addAll(data!);
        if ((data?.length ?? 0) < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      onCompleted(data);
      return data;
    } catch (e, _) {
      _curPage--;
      refreshController.loadFailed();
      onCompleted(null);
      return null;
    }
  }

  // 加载数据
  Future<List<T>?> loadData({int page});

  // 数据完成时候调用
  onCompleted(List<T>? data) {}

  @override
  void onClose() {
    _refreshController.dispose();
    super.onClose();
  }
}
