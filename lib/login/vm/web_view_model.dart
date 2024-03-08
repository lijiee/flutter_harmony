import 'package:cailueedu/base/vm/base_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewModel extends BaseViewModel {
  String title = "";
  String url = "";
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
}
