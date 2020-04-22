import 'dart:async';

import 'package:yun_base/http/yun_http.dart';
import 'package:yun_base/model/yun_base_map_model.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/models/plan_vo.dart';
import 'package:yun_record/models/theme_temp_vo.dart';
import 'package:yun_record/models/theme_vo.dart';

import 'custom_data_vo.dart';
import 'custom_vo.dart';
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
    YunBaseMapModel rst =
        await YunHttp(model).post(YunBaseMapModel(), "/v1/api/record/theme/checkTemplate", null, null);

    return rst;
  }

  static Future<YunBaseMapModel> saveThemeData<N extends YunPageBaseNotiModel>(N model, data) async {
    YunBaseMapModel rst = await YunHttp(model).post(YunBaseMapModel(), "/v1/api/record/themeTagData", data, null);

    return rst;
  }

  /// 获取主题列表
  static Future<List<ThemeVo>> getThemeList<N extends YunPageBaseNotiModel>(N model, String name, {bool tag}) async {
    var qP = Map<String, dynamic>();
    if (YunValue.hasContent(name)) {
      qP['name'] = name;
    }

    if(tag !=null){
      qP['tag'] = tag;
    }

    List<ThemeVo> rst = await YunHttp(model).get(ThemeVo(), "/v1/api/record/theme/list", qP, dIsList: true);

    return rst;
  }

  /// 获取主题详情
  static Future<ThemeVo> getThemeDetails<N extends YunPageBaseNotiModel>(N model, int themeId) async {
    ThemeVo rst = await YunHttp(model).get(ThemeVo(), "/v1/api/record/theme/${themeId.toString()}", null);

    return rst;
  }

  static Future<YunBaseMapModel> deleteTheme<N extends YunPageBaseNotiModel>(N model, int themeId) async {
    YunBaseMapModel rst = await YunHttp(model).delete(YunBaseMapModel(), "/v1/api/record/theme/${themeId.toString()}");

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

    List<ThemeTempVo> rst =
        await YunHttp(model).get(ThemeTempVo(), "/v1/api/record/themeTemplate/list", qP, dIsList: true);

    return rst;
  }

  /// 获取主题详情
  static Future<ThemeTempVo> getThemeTempDetails<N extends YunPageBaseNotiModel>(N model, int themeTempId) async {
    ThemeTempVo rst =
        await YunHttp(model).get(ThemeTempVo(), "/v1/api/record/themeTemplate/${themeTempId.toString()}", null);

    return rst;
  }

  static Future<YunBaseMapModel> createThemeByTemplate<N extends YunPageBaseNotiModel>(N model, data) async {
    YunBaseMapModel rst =
        await YunHttp(model).post(YunBaseMapModel(), "/v1/api/record/theme/createByTemplate", data, null);

    return rst;
  }

  static Future<YunBaseMapModel> saveCustomTheme<N extends YunPageBaseNotiModel>(N model, data) async {
    YunBaseMapModel rst = await YunHttp(model).post(YunBaseMapModel(), "/v1/api/record/theme", data, null);

    return rst;
  }

  /// ---- plan
  /// 保存
  static Future<PlanVo> savePlan<N extends YunPageBaseNotiModel>(N model, data) async {
    PlanVo rst = await YunHttp(model).post(PlanVo(), "/v1/api/plan", data, null);

    return rst;
  }

  /// 列表
  static Future<List<PlanVo>> getPlanList<N extends YunPageBaseNotiModel>(N model, String name,
      {int sortType, int showType}) async {
    var qP = Map<String, dynamic>();
    if (YunValue.hasContent(name)) {
      qP['name'] = name;
    }

    if (sortType != null) {
      qP['sortType'] = sortType;
    }
    if (showType != null) {
      qP['showType'] = showType;
    }

    List<PlanVo> rst = await YunHttp(model).get(PlanVo(), "/v1/api/plan/list", qP, dIsList: true);

    return rst;
  }

  /// 更新状态
  static Future<PlanVo> savePlanStatus<N extends YunPageBaseNotiModel>(N model, int id, int status) async {
    PlanVo user = await YunHttp(model).post(PlanVo(), "/v1/api/plan/status/${id}/${status}", null, null);

    return user;
  }

  /// 习惯
  /// 获取列表
  static Future<List<CustomDataVo>> getCustomDataList<N extends YunPageBaseNotiModel>(N model, String date) async {
    var qP = Map<String, dynamic>();
    if (YunValue.hasContent(date)) {
      qP['date'] = date;
    }

    List<CustomDataVo> rst = await YunHttp(model).get(CustomDataVo(), "/v1/api/customData/list", qP, dIsList: true);

    return rst;
  }

  static Future<YunBaseMapModel> saveCustomRecordData<N extends YunPageBaseNotiModel>(N model, data) async {
    YunBaseMapModel rst = await YunHttp(model).post(YunBaseMapModel(), "/v1/api/customData/saveData", data, null);

    return rst;
  }

  static Future<CustomDataVo> saveCustom<N extends YunPageBaseNotiModel>(N model, data) async {
    CustomDataVo rst = await YunHttp(model).post(CustomDataVo(), "/v1/api/custom", data, null);

    return rst;
  }

  static Future<List<Custom>> getCustomList<N extends YunPageBaseNotiModel>(N model, String name) async {
    var qP = Map<String, dynamic>();
    if (YunValue.hasContent(name)) {
      qP['name'] = name;
    }

    List<Custom> rst = await YunHttp(model).get(Custom(), "/v1/api/custom/list", qP, dIsList: true);

    return rst;
  }

  /// user
  static Future<UserVo> getUserInfo<N extends YunPageBaseNotiModel>(N model) async {
    UserVo rst = await YunHttp(model).get(UserVo(), "/v1/api/my/myInfo", null);

    return rst;
  }
}
