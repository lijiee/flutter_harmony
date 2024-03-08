import 'package:cailueedu/base/widget/base_page.dart';
import 'package:cailueedu/login/vm/web_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends BasePage<WebViewModel> {
  const WebPage({super.key});
  @override
  void initViewModel() {
    super.initViewModel();
    Get.put(WebViewModel());
    final Map<String, dynamic> args = Get.arguments;
    final String title = args['title'];
    final String url = args['url'];
    viewModel.url = url;
    viewModel.title = title;
    viewModel.webViewController.loadRequest(Uri.parse(url));
  }

  @override
  Widget buildContent(BuildContext context) {
    return WebViewWidget(controller: viewModel.webViewController);
  }

  @override
  String titleString() {
    return viewModel.title;
  }
}
