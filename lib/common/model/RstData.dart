import 'package:yun_record/util/ValueUtils.dart';

import 'BaseModel.dart';

class RstDataDefine {
  static final codeName = 'code';
  static final dataName = 'data';
  static final msgName = 'errorMsg';

  static final int sucCode = 200;
  static final int commonErrorCode = -1;
}

class RspData<T extends BaseModel> {
  /// 返回类型：1-HTTP状态数据;2-业务数据;
  /// 默认值：2
  int type;

  int code;
  Map<String, dynamic> dataMap;
  String errorMsg;

  T data;

  RspData({type: 2});

  factory RspData.fromJson(T d, Map<String, dynamic> map) {
    var item = new RspData<T>();

    try {
      if (map[RstDataDefine.codeName] == null) {
        return item.updateError(RstDataDefine.commonErrorCode, "数据格式不正确");
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
      return item.updateError(RstDataDefine.commonErrorCode, e.toString());
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

  RspData<T> updateError(int code, String errorMsg) {
    this.code = code;
    this.errorMsg = errorMsg;
    this.data = null;

    return this;
  }

  bool isSuc() {
    return code == RstDataDefine.sucCode;
  }
}
