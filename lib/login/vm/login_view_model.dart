import 'package:cailueedu/app.dart';
import 'package:cailueedu/base/vm/base_view_model.dart';
import 'package:cailueedu/net/http_request.dart';
import 'package:cailueedu/utils/api_utils.dart';
import 'package:cailueedu/utils/check_utils.dart';
import 'package:cailueedu/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class LoginViewModel extends BaseViewModel {
  RxInt index = 0.obs;
  RxBool obscureText = true.obs;
  RxInt count = 0.obs;
  final TextEditingController phoneEditController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  final TextEditingController passEditController = TextEditingController();
  final FocusNode passFocusNode = FocusNode();
  RxBool selectCheck = true.obs;
  @override
  void onInit() {
    super.onInit();
    httpRequest(ApiUtils().serviceApi().queryKeyMap(),
            showLoading: false, showToast: false)
        .then((value) {
      if (value?.publicKey?.isNotEmpty ?? false) {
        SPUtils().setString(kPublicKey, value.publicKey);
      }
      if (value?.sign?.isNotEmpty ?? false) {
        SPUtils().setString(kSign, value.sign);
      }
    });

    phoneEditController.addListener(() {
      notifyListeners();
    });
    passEditController.addListener(() {
      notifyListeners();
    });
  }

  changeSelect(int value) {
    hiddenKeyboard(Get.context);
    if (index.value == value) {
      return;
    }
    passEditController.text = "";
    index.value = value;
  }

  changeShow() {
    obscureText.value = !obscureText.value;
  }

  changeCheck() {
    selectCheck.value = !selectCheck.value;
  }

  loginAction() {
    String phone = phoneEditController.text ?? "";
    String pass = passEditController.text ?? "";
    if (phone.isEmpty || !CheckUtils().isPhone(phone)) {
      SmartDialog.showToast("请输入正确的手机号");
      return;
    }
    if (pass.isEmpty) {
      SmartDialog.showToast(index.value == 0 ? "请输入密码" : "请输入验证码");
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    passEditController.removeListener(() {});
    passEditController.dispose();
    phoneEditController.removeListener(() {});
    phoneEditController.dispose();
  }
}
