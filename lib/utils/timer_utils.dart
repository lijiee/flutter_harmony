import 'dart:async';

///***********************************************///
/// Name:      TimerUtil
/// Desc:      倒计时
/// Author:    lijiee
/// Date:      2022/8/12 14:11
///**********************************************///

typedef OnTimerTickCallback = void Function(int millisUntilFinished);

class TimerUtil {
  /// Timer interval (unit millisecond，def: 1000 millisecond).
  /// Timer间隔 单位毫秒，默认1000毫秒(1秒).
  int mInterval;

  /// countdown totalTime.
  /// 倒计时总时间
  int mTotalTime; //单位毫秒

  TimerUtil(this.mTotalTime, this.onTimerTickCallback,
      {this.mInterval = Duration.millisecondsPerSecond});

  /// Timer.
  Timer? _mTimer;

  /// Is Timer active.
  /// Timer是否启动.
  bool _isActive = false;

  OnTimerTickCallback onTimerTickCallback;

  /// set Timer interval. (unit millisecond).
  /// 设置Timer间隔.
  void setInterval(int interval) {
    if (interval <= 0) interval = Duration.millisecondsPerSecond;
    mInterval = interval;
  }

  /// set countdown totalTime. (unit millisecond).
  /// 设置倒计时总时间.
  void setTotalTime(int totalTime) {
    if (totalTime <= 0) return;
    mTotalTime = totalTime;
  }

  /// start Timer.
  /// 启动定时Timer.
  void startTimer() {
    if (_isActive || mInterval <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInterval);
    _doCallback(0);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      _doCallback(timer.tick);
    });
  }

  /// start countdown Timer.
  /// 启动倒计时Timer.
  void startCountDown() {
    if (_isActive || mInterval <= 0 || mTotalTime <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInterval);
    _doCallback(mTotalTime);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      int time = mTotalTime - mInterval;
      mTotalTime = time;
      if (time >= mInterval) {
        _doCallback(time);
      } else if (time == 0) {
        _doCallback(time);
        cancel();
      } else {
        timer.cancel();
        Future.delayed(Duration(milliseconds: time), () {
          mTotalTime = 0;
          _doCallback(0);
          cancel();
        });
      }
    });
  }

  void _doCallback(int time) {
    onTimerTickCallback(time);
  }

  /// update countdown totalTime.
  /// 重设倒计时总时间.
  void updateTotalTime(int totalTime) {
    cancel();
    mTotalTime = totalTime;
    startCountDown();
  }

  /// timer is Active.
  /// Timer是否启动.
  bool isActive() {
    return _isActive;
  }

  /// Cancels the timer.
  /// 取消计时器.
  void cancel() {
    if (_mTimer != null) {
      _mTimer?.cancel();
      _mTimer = null;
    }
    _isActive = false;
  }
}
