import 'dart:async';

import 'package:yun_record/common/util/ValueUtils.dart';
import 'package:yun_record/models/ThemeVo.dart';

import '../common/http/HttpHelper.dart';
import '../common/model/PageBaseNotiModel.dart';
import 'ThemeDataVo.dart';
import 'UserVo.dart';

class Api {
  /// 登录接口，登录成功后返回用户信息
  static Future<UserVo> login<N extends PageBaseNotiModel>(N model, String name, String pwd) async {
    var qP = Map<String, dynamic>();
    qP["acctName"] = name;
    qP["password"] = pwd;

    UserVo user = await HttpHelper(model).post(UserVo(), "/v1/api/login/login", null, qP);

    return user;
  }

  /// 获取主题列表
  static Future<List<ThemeVo>> getThemeList<N extends PageBaseNotiModel>(N model, String name) async {
    var qP = Map<String, dynamic>();
    if (ValueUtils.hasContent(name)) {
      qP['name'] = name;
    }

    List<ThemeVo> rst = await HttpHelper(model).get(ThemeVo(), "/v1/api/record/theme/list", qP,dIsList: true);

    return rst;
  }

  static Future<List<ThemeDataVo>> getThemeDataList<N extends PageBaseNotiModel>(N model, String date,int tagId,int themeId) async {
    var qP = Map<String, dynamic>();
    if (ValueUtils.hasContent(date)) {
      qP['date'] = date;
    }
    if (tagId!=null) {
      qP['tagId'] = tagId;
    }
    if (themeId!=null) {
      qP['themeId'] = themeId;
    }

    List<ThemeDataVo> rst = await HttpHelper(model).get(ThemeDataVo(), "/v1/api/record/themeData/list", qP,dIsList: true);

    return rst;
  }
}
