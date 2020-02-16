import 'dart:io';

import 'package:dio/dio.dart';
import 'package:yun_record/common/log/LogHelper.dart';
import 'package:yun_record/common/model/BaseModel.dart';
import 'package:yun_record/common/model/PageBaseNotiModel.dart';
import 'package:yun_record/common/model/RstData.dart';

import '../global.dart';

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

    String token = null;
    if (Global.userVo != null) {
      token = Global.userVo.loginToken;
    }
    if (token != null) {
      defHeaders[HttpHeaders.authorizationHeader] = token;
    }

    dio = new Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: defHeaders,
    ));
  }

  Future<D> post<D extends BaseModel>(D d, String path, data, Map<String, dynamic> queryParameters) async {
    Response<Map<String, dynamic>> rsp;
    try {
      rsp = await dio.post(
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

    RspData<D> vo = RspData.fromJson(d, rsp.data);

    rsp.request.path;
    rsp.request.headers;
    rsp.request.queryParameters;

    Log.logRsp(vo.toJson(),
        path: rsp.request.path, headers: rsp.request.headers, qParams: rsp.request.queryParameters);

    if (vo.isSuc()) {
      hideLoading();
      return vo.data;
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
