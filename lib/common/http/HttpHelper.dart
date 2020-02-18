//
// Created by yun on 2020-02-18.
//

import 'package:dio/dio.dart';
import 'package:yun_record/common/log/LogHelper.dart';
import 'package:yun_record/common/model/BaseModel.dart';
import 'package:yun_record/common/model/PageBaseNotiModel.dart';
import 'package:yun_record/common/model/RstData.dart';

class HttpHelper<N extends PageBaseNotiModel> {
  // region static

  // base url
  static String baseUrl;

  /// 默认header
  static Map<String, dynamic> defHeaders;

  /// 基于N（PageBaseNotiModel）：主动处理状态和信息显示
  static bool handleState = true;

  static addHeader(String key, dynamic value) {
    if (key == null) {
      return;
    }

    if (value == null) {
      removeHeader(key);
      return defHeaders;
    }

    if (defHeaders == null) {
      defHeaders = {};
    }

    defHeaders[key] = value;

    return defHeaders;
  }

  static removeHeader(String key) {
    if (key == null || defHeaders == null) {
      return;
    }

    return defHeaders.remove(key);
  }

  // endregion

  Dio dio;
  N _noti;

  RspData rstData;

  HttpHelper(N noti) {
    this._noti = noti;

    if (defHeaders == null) {
      defHeaders = {};
    }

    dio = new Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: defHeaders,
    ));
  }

  // region rqt

  Future post<D extends BaseModel>(D d, String path, data, Map<String, dynamic> queryParameters,
      {bool dIsList = false}) async {
    Response<Map<String, dynamic>> rsp;

    try {
      rsp = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } catch (e) {
      return _handleRspError(e, path, queryParameters);
    }

    return _handleRsp(d, rsp, dIsList);
  }

  Future get<D extends BaseModel>(D d, String path, Map<String, dynamic> queryParameters,
      {bool dIsList = false}) async {
    Response<Map<String, dynamic>> rsp;

    try {
      rsp = await dio.get(
        path,
        queryParameters: queryParameters,
      );
    } catch (e) {
      return _handleRspError(e, path, queryParameters);
    }

    return _handleRsp(d, rsp, dIsList);
  }

  dynamic _handleRspError(e, String path, Map<String, dynamic> queryParameters) {
    // 日志
    Log.logRsp(e.toString(), path: path, headers: null, qParams: queryParameters);

    rstData = RspData.fromRspError(e);

    showRspError(rstData);

    return handleState ? null : rstData;
  }

  dynamic _handleRsp<D extends BaseModel>(D d, Response<Map<String, dynamic>> rsp, dIsList) {
    if (rsp != null) {
      Log.logRsp(rsp.data, path: rsp.request.path, headers: rsp.request.headers, qParams: rsp.request.queryParameters);
    }
    RspData<D> vo = dIsList ? RspData.fromListJson(d, rsp.data) : RspData.fromJson(d, rsp.data);
    rstData = vo;

    if (rstData.isSuc()) {
      hideLoading();
      return dIsList ? rstData.dataList : rstData.data;
    }

    showRspError(rstData);

    return handleState ? null : rstData;
  }

  // endregion

  // region handleState

  void showRspError(RspData rst) {
    if (!handleState) {
      return;
    }

    // 根据模式显示信息
    showError(rst.errorMsg);
  }

  void showError(String err) {
    if (!handleState) {
      return;
    }

    hideLoading();

    if (_noti != null) {
      _noti.showErr(err);
    }
  }

  void hideLoading() {
    if (!handleState) {
      return;
    }

    if (_noti != null) {
      _noti.finishLoading();
    }
  }

// endregion

}
