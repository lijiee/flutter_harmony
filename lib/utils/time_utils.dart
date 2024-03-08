///***********************************************///
/// Name:     TimeUtil
/// Desc:      时间工具类
/// Author:    lijiee
/// Date:      2022/8/12 14:11
///**********************************************///

class TimeUtil {
  static int getTime(DateTime? time) {
    if (time == null) {
      return (DateTime.now().millisecondsSinceEpoch / 1000).round();
    } else {
      return (time.millisecondsSinceEpoch / 1000).round();
    }
  }
}
