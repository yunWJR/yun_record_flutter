import 'dart:io';

import 'package:dio/dio.dart';
import 'package:yun_record/common/log/LogHelper.dart';
import 'package:yun_record/common/model/BaseModel.dart';
import 'package:yun_record/common/model/PageBaseNotiModel.dart';
import 'package:yun_record/common/model/RstData.dart';
import 'package:yun_record/common/util/ValueUtils.dart';
import 'package:yun_record/config/GlobalConfig.dart';

class HttpHelper<N extends PageBaseNotiModel> {
  static String baseUrl = "http://fffy.api.yunsoho.cn";

  static Map<String, dynamic> defHeaders;

  Dio dio;
  N noti;

  HttpHelper(N noti) {
    this.noti = noti;

    if (defHeaders == null) {
      defHeaders = {};
    }

    if (ValueUtils.hasContent(GlobalConfig.loginToken)) {
      defHeaders[HttpHeaders.authorizationHeader] = GlobalConfig.loginToken;
    }

    dio = new Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: defHeaders,
    ));
  }

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
      //登录失败则提示
      if (e.response?.statusCode == 401) {
        showError('登录失败'); // todo
      } else {
        showError(e.toString());
      }

      return null;
    }

    Log.logRsp(rsp.data, path: rsp.request.path, headers: rsp.request.headers, qParams: rsp.request.queryParameters);

    RspData<D> vo;
    if (dIsList) {
      vo = RspData.fromListJson(d, rsp.data);
    } else {
      vo = RspData.fromJson(d, rsp.data);
    }

    if (vo.isSuc()) {
      hideLoading();
      if (dIsList) {
        return vo.dataList;
      } else {
        return vo.data;
      }
    }

    showRspError(vo);

    return null;
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
      //登录失败则提示
      if (e.response?.statusCode == 401) {
        showError('登录失败'); // todo
      } else {
        showError(e.toString());
      }

      return null;
    }

    Log.logRsp(rsp.data, path: rsp.request.path, headers: rsp.request.headers, qParams: rsp.request.queryParameters);

    RspData<D> vo;
    if (dIsList) {
      vo = RspData.fromListJson(d, rsp.data);
    } else {
      vo = RspData.fromJson(d, rsp.data);
    }

    if (vo.isSuc()) {
      hideLoading();
      if (dIsList) {
        return vo.dataList;
      } else {
        return vo.data;
      }
    }

    showRspError(vo);

    return null;
  }

  void showRspError(RspData rst) {
    // 根据模式显示信息
    showError(rst.errorMsg);
  }

  void showError(String err) {
    hideLoading();

    if (noti != null) {
      noti.showErr(err);
    }
  }

  void hideLoading() {
    if (noti != null) {
      noti.finishLoading();
    }
  }
}
