//
// Created by yun on 2020-02-18.
//

import 'package:yun_record/common/util/ValueUtils.dart';

import 'YunBaseModel.dart';

///
enum YunRspDataType { BaseModel, HTTP }

class YunRstDataDefine {
  static final codeName = 'code';
  static final dataName = 'data';
  static final msgName = 'errorMsg';

  static final int sucCode = 200;
  static final int commonErrorCode = -1;
}

class RspData<T extends YunBaseModel> {
  /// 返回类型：1-HTTP状态数据;2-业务数据;
  /// 默认值：2
  YunRspDataType type;

  int code;
  dynamic orgData; // Map<String, dynamic> 或者 list
  String errorMsg;

  T data;
  List<T> dataList;

  RspData({this.type: YunRspDataType.BaseModel});

  factory RspData.fromJson(T d, Map<String, dynamic> map) {
    var item = new RspData<T>(type: YunRspDataType.BaseModel);

    try {
      if (map[YunRstDataDefine.codeName] == null) {
        return item.updateError(YunRstDataDefine.commonErrorCode, "数据格式不正确");
      }

      item.code = map[YunRstDataDefine.codeName];

      // 错误
      if (item.code != YunRstDataDefine.sucCode) {
        item.errorMsg = map[YunRstDataDefine.msgName];
        if (ValueUtils.isNullOrEmpty(item.errorMsg)) {
          item.errorMsg = '未知错误';
        }

        return item;
      }

      // 成功-解析 data
      item.orgData = map[YunRstDataDefine.dataName];

      item.data = d.fromJson(item.orgData);
    } catch (e) {
      return item.updateError(YunRstDataDefine.commonErrorCode, e.toString(), orgData: e);
    }

    return item;
  }

  factory RspData.fromListJson(T d, Map<String, dynamic> map) {
    var item = new RspData<T>(type: YunRspDataType.BaseModel);

    try {
      if (map[YunRstDataDefine.codeName] == null) {
        return item.updateError(YunRstDataDefine.commonErrorCode, "数据格式不正确");
      }

      item.code = map[YunRstDataDefine.codeName];

      // 错误
      if (item.code != YunRstDataDefine.sucCode) {
        item.errorMsg = map[YunRstDataDefine.msgName];
        if (ValueUtils.isNullOrEmpty(item.errorMsg)) {
          item.errorMsg = '未知错误';
        }

        return item;
      }

      // 成功-解析 data
      List list = map[YunRstDataDefine.dataName];

      item.orgData = list;

      item.dataList = list.map<T>((e) => d.fromJson(e)).toList();
    } catch (e) {
      return item.updateError(YunRstDataDefine.commonErrorCode, e.toString(), orgData: e);
    }

    return item;
  }

  factory RspData.fromRspError(e) {
    print('fromRspError');
    print(e);

    var item = new RspData<T>(type: YunRspDataType.HTTP);
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

    // 自定义字段
    data['type'] = this.type;
    data['orgData'] = this.orgData;

    return data;
  }

  RspData<T> updateError(int code, String errorMsg, {orgData}) {
    this.code = code;
    this.errorMsg = errorMsg;
    this.data = null;
    this.orgData = orgData;

    return this;
  }

  bool isSuc() {
    return code == YunRstDataDefine.sucCode;
  }
}
