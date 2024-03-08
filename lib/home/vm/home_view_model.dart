import 'package:cailueedu/base/vm/base_view_model.dart';
import 'package:cailueedu/net/http_request.dart';
import 'package:cailueedu/utils/api_utils.dart';
import 'package:cailueedu/utils/encrypt_utils.dart';
import 'package:get/get.dart';

class HomeViewModel extends BaseViewModel {
  @override
  Future initData() async {
    // httpRequest(ApiUtils().serviceApi().getCommonQuestionTypeList());
    // httpRequest(ApiUtils().serviceNouYiApi().reciteList());
    httpRequest(ApiUtils().serviceApi().queryKeyMap()).then((value) {
    String userPassword =
        EncryptUtils.encryptRSA("rh123456", value?.publicKey ?? "");
    String account = "18612115211";
    String rsaSign = value?.sign ?? "";
    });
    // EncryptUtils.encryptAES("15102702200");
    return Future.value(1);
  }
}
