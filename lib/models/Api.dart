import 'dart:async';

import 'package:yun_record/common/model/YunBaseMapModel.dart';
import 'package:yun_record/common/util/ValueUtils.dart';
import 'package:yun_record/models/ThemeVo.dart';

import '../common/http/YunHttp.dart';
import '../common/model/YunPageBaseNotiModel.dart';
import 'ThemeDataVo.dart';
import 'UserVo.dart';

class Api {
  /// 登录接口，登录成功后返回用户信息
  static Future<UserVo> login<N extends YunPageBaseNotiModel>(N model, String name, String pwd) async {
    var qP = Map<String, dynamic>();
    qP["acctName"] = name;
    qP["password"] = pwd;

    UserVo user = await YunHttp(model).post(UserVo(), "/v1/api/login/login", null, qP);

    return user;
  }

  static Future<YunBaseMapModel> saveThemeData<N extends YunPageBaseNotiModel>(N model, data) async {
    data ={}; // todo
    YunBaseMapModel rst = await YunHttp(model).post(YunBaseMapModel(), "/v1/api/record/themeTagData", data, null);

    return rst;
  }

  /// 获取主题列表
  static Future<List<ThemeVo>> getThemeList<N extends YunPageBaseNotiModel>(N model, String name) async {
    var qP = Map<String, dynamic>();
    if (ValueUtils.hasContent(name)) {
      qP['name'] = name;
    }

    List<ThemeVo> rst = await YunHttp(model).get(ThemeVo(), "/v1/api/record/theme/list", qP, dIsList: true);

    return rst;
  }

  /// 获取主题详情
  static Future<ThemeVo> getThemeDetails<N extends YunPageBaseNotiModel>(N model, int themeId) async {
    ThemeVo rst = await YunHttp(model).get(ThemeVo(), "/v1/api/record/theme/${themeId.toString()}", null);

    return rst;
  }

  /// 获取主题数据列表
  static Future<List<ThemeDataVo>> getThemeDataList<N extends YunPageBaseNotiModel>(
      N model, String date, int tagId, int themeId) async {
    var qP = Map<String, dynamic>();
    if (ValueUtils.hasContent(date)) {
      qP['date'] = date;
    }
    if (tagId != null) {
      qP['tagId'] = tagId;
    }
    if (themeId != null) {
      qP['themeId'] = themeId;
    }

    List<ThemeDataVo> rst =
        await YunHttp(model).get(ThemeDataVo(), "/v1/api/record/themeData/list", qP, dIsList: true);

    return rst;
  }
}
