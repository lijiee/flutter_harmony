import 'package:cailueedu/base/vm/view_model_state.dart';
import 'package:cailueedu/log/logger.dart';
import 'package:get/get.dart';

///***********************************************///
/// Name:      BaseViewModel
/// Desc:      基础类
/// Author:    lijiee
/// Date:      2022/8/12 14:13
///**********************************************///

abstract class BaseViewModel extends GetxController {
  static const String tag = "[BaseViewModel]'";
  bool _disposed = false;
  ModelState _modelState = ModelState.idle;

  ModelState get modelState => _modelState;

  set modelState(ModelState modelState) {
    Logger.d("${tag}modelState$modelState");
    _modelState = modelState;
    notifyListeners();
  }

  bool get isBusy => modelState == ModelState.busy;

  bool get isIdle => modelState == ModelState.idle;

  bool get isEmpty => modelState == ModelState.empty;

  bool get isError => modelState == ModelState.error;

  bool get isNotNet => modelState == ModelState.notNet;

  void setIdle() {
    modelState = ModelState.idle;
  }

  void setBusy() {
    modelState = ModelState.busy;
  }

  void setEmpty() {
    modelState = ModelState.empty;
  }

  void setError() {
    modelState = ModelState.error;
  }

  void setNotNet() {
    modelState = ModelState.notNet;
  }

  ///通知UI刷新时候调用
  void notifyListeners([List<String>? ids, bool condition = true]) {
    if (!_disposed) {
      update(ids, condition);
    }
  }

  ///ViewModel初始化的时候调用
  @override
  void onInit() {
    super.onInit();
    Logger.d("${tag}onInit()");
  }

  ///UI初始显示时候调用
  @override
  void onReady() {
    super.onReady();
    Logger.d("${tag}onReady()");
  }

  ///ViewModel从内存删除的时候调用
  @override
  void onClose() {
    _disposed = true;
    super.onClose();
    Logger.d("${tag}onClose()");
  }
}
