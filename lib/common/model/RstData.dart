import 'package:yun_record/util/ValueUtils.dart';

import 'BaseModel.dart';

class RstDataDefine {
  static final codeName = 'code';
  static final dataName = 'data';
  static final msgName = 'errorMsg';

  static final int sucCode = 200;
  static final int commonErrorCode = -1;
}

class RstData<T extends BaseModel> {
  int code;
  Map<String, dynamic> dataMap;
  String errorMsg;

  T data;

  RstData();

  RstData update(int code, T data, String errorMsg) {
    this.code = code;
    this.data = data;
    this.errorMsg = errorMsg;
  }

  factory RstData.fromJson(T d, Map<String, dynamic> map) {
    var item = new RstData<T>();

    try {
      if (map[RstDataDefine.codeName] == null) {
        return item.update(RstDataDefine.commonErrorCode, null, "数据格式不正确");
      }

      item.code = map[RstDataDefine.codeName];

      // 错误
      if (item.code != RstDataDefine.sucCode) {
        item.errorMsg = map[RstDataDefine.msgName];
        if (ValueUtils.isNullOrEmpty(item.errorMsg)) {
          item.errorMsg = '未知错误';
        }

        return item;
      }

      // 成功-解析 data
      item.dataMap = map[RstDataDefine.dataName];

      item.data = d.fromJson(item.dataMap);
    } catch (e) {
      return item.update(RstDataDefine.commonErrorCode, null, e.toString());
    }

    return item;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['errorMsg'] = this.errorMsg;
    data['data'] = this.data.toJson();

    return data;
  }

  bool isSuc() {
    return code == RstDataDefine.sucCode;
  }
}
