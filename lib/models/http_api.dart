import 'dart:async';

import 'package:yun_base/http/yun_http.dart';
import 'package:yun_base/model/yun_base_map_model.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/models/theme_temp_vo.dart';
import 'package:yun_record/models/theme_vo.dart';

import 'theme_data_vo.dart';
import 'user_vo.dart';

class Api {
  /// 登录接口，登录成功后返回用户信息
  static Future<UserVo> register<N extends YunPageBaseNotiModel>(N model, String name, String pwd) async {
    var qP = Map<String, dynamic>();
    qP["acctName"] = name;
    qP["password"] = pwd;

    UserVo user = await YunHttp(model).post(UserVo(), "/v1/api/login/register", null, qP);

    return user;
  }

  /// 登录接口，登录成功后返回用户信息
  static Future<UserVo> login<N extends YunPageBaseNotiModel>(N model, String name, String pwd) async {
    var qP = Map<String, dynamic>();
    qP["acctName"] = name;
    qP["password"] = pwd;

    UserVo user = await YunHttp(model).post(UserVo(), "/v1/api/login/login", null, qP);

    return user;
  }

  static Future<YunBaseMapModel> checkTheme<N extends YunPageBaseNotiModel>(N model) async {
    YunBaseMapModel rst = await YunHttp(model).post(YunBaseMapModel(), "/v1/api/record/theme/checkTemplate", null, null);

    return rst;
  }

  static Future<YunBaseMapModel> saveThemeData<N extends YunPageBaseNotiModel>(N model, data) async {
    YunBaseMapModel rst = await YunHttp(model).post(YunBaseMapModel(), "/v1/api/record/themeTagData", data, null);

    return rst;
  }

  /// 获取主题列表
  static Future<List<ThemeVo>> getThemeList<N extends YunPageBaseNotiModel>(N model, String name) async {
    var qP = Map<String, dynamic>();
    if (YunValue.hasContent(name)) {
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
    if (YunValue.hasContent(date)) {
      qP['date'] = date;
    }
    if (tagId != null) {
      qP['tagId'] = tagId;
    }
    if (themeId != null) {
      qP['themeId'] = themeId;
    }

    List<ThemeDataVo> rst = await YunHttp(model).get(ThemeDataVo(), "/v1/api/record/themeData/list", qP, dIsList: true);

    return rst;
  }

  /// 获取主题模板列表
  static Future<List<ThemeTempVo>> getThemeTempList<N extends YunPageBaseNotiModel>(N model, String name) async {
    var qP = Map<String, dynamic>();
    if (YunValue.hasContent(name)) {
      qP['name'] = name;
    }

    List<ThemeTempVo> rst = await YunHttp(model).get(ThemeTempVo(), "/v1/api/record/themeTemplate/list", qP, dIsList: true);

    return rst;
  }
}
