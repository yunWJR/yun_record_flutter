class Log {
  static log(String tag, data) {
    if (_canLog()) {
      print(DateTime.now().toString() + "--------------" + (tag ?? "未知") + "--------------");
      print(data ?? "null");
    }
  }

  static logTag(String tag) {
    if (_canLog()) {
      print(DateTime.now().toString() + "--------------" + (tag ?? "未知") + "--------------");
    }
  }

  static logDivide(String tag, bool isStart) {
    if (_canLog()) {
      if (isStart) {
        print("START ▼▼▼▼▼▼▼▼▼▼▼▼▼▼ " + (tag ?? "未知") + " ▼▼▼▼▼▼▼▼▼▼▼▼▼▼ START");
      } else {
        print("END ▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲ " + (tag ?? "未知") + " ▲▲▲▲▲▲▲▲▲▲▲▲▲ END");
      }
    }
  }

  static logData(data) {
    if (_canLog()) {
      print(data ?? "null");
    }
  }

  static logRsp(data, {String path, Map<String, dynamic> headers, Map<String, dynamic> qParams}) {
    logDivide("HTTP RQT:" + DateTime.now().toString(), true);

    log("path", path);
    log("headers", headers);
    log("qParams", qParams);
    log("rsp data", data);

    logDivide("HTTP RQT:" + DateTime.now().toString(), false);
  }

  static bool _canLog() {
    return true;
  }
}
