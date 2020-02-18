import 'package:yun_record/common/util/ValueUtils.dart';

import 'BaseModel.dart';

enum RspDataType { BaseModel, HTTP }

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
  RspDataType type;

  int code;
  dynamic orgData; // Map<String, dynamic> 或者 list
  String errorMsg;

  T data;
  List<T> dataList;

  RspData({type: RspDataType.BaseModel});

  factory RspData.fromJson(T d, Map<String, dynamic> map) {
    var item = new RspData<T>(type: RspDataType.BaseModel);

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
      item.orgData = map[RstDataDefine.dataName];

      item.data = d.fromJson(item.orgData);
    } catch (e) {
      return item.updateError(RstDataDefine.commonErrorCode, e.toString());
    }

    return item;
  }

  factory RspData.fromListJson(T d, Map<String, dynamic> map) {
    var item = new RspData<T>(type: RspDataType.BaseModel);

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
      List list = map[RstDataDefine.dataName];

      item.orgData = list;

      item.dataList = list.map<T>((e) => d.fromJson(e)).toList();
    } catch (e) {
      return item.updateError(RstDataDefine.commonErrorCode, e.toString());
    }

    return item;
  }

  factory RspData.fromRspError(e) {
    print('fromRspError');
    print(e);

    var item = new RspData<T>(type: RspDataType.HTTP);
    item.orgData = e;

    if (e.response?.statusCode == 401) {
      item.code = 401;
      item.errorMsg = "登录已经过期，请重新登录";
    } else {
      item.code = -1;
      item.errorMsg = e.toString();
    }

    return item;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['errorMsg'] = this.errorMsg;
    data['data'] = this.data?.toJson(); // todo ?. 检查

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
