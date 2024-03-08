extension ExString on String {
  /// Desc:      images目录下的图片
  String intoImgPath() {
    return "assets/images/$this";
  }

  /// Desc:      images/empty
  String intoImgEmptyPath() {
    return "assets/images/empty/$this";
  }

  /// Desc:      images/tab
  String intoImgTabPath() {
    return "assets/images/tab/$this";
  }

  /// Desc:      images/login
  String intoImgLoginPath() {
    return "assets/images/login/$this";
  }

}
