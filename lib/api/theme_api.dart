import 'dart:async';

import 'package:yun_base/http/yun_http.dart';
import 'package:yun_base/model/yun_base_map_model.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/model/yun_rst_data.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/models/IdsDto.dart';
import 'package:yun_record/models/TagDataVo.dart';
import 'package:yun_record/models/sel_user_vo.dart';
import 'package:yun_record/models/theme_vo.dart';

class ThemeApi {
  /// 获取主题列表
  static Future<List<ThemeVo>> getThemeList<N extends YunPageBaseNotiModel>(N model, String name) async {
    var qP = Map<String, dynamic>();
    if (YunValue.hasContent(name)) {
      qP['name'] = name;
    }

    YunRspData<ThemeVo> rst = await YunHttp(model).get(null, "/v1/api/theme/list", qP, dIsList: true);

    return rst?.dataList;
  }

  /// 获取主题列表
  static Future<List<ThemeVo>> getThemeTagList<N extends YunPageBaseNotiModel>(
      N model, String name, int themeId) async {
    var qP = Map<String, dynamic>();
    if (YunValue.hasContent(name)) {
      qP['name'] = name;
    }
    if (themeId != null) {
      qP['themeId'] = themeId;
    }

    YunRspData<ThemeVo> rst = await YunHttp(model).get(null, "/v1/api/record/tag/themeTagList", qP, dIsList: true);

    return rst?.dataList;
  }

  /// 获取主题详情
  static Future<ThemeVo> getThemeDetails<N extends YunPageBaseNotiModel>(N model, int themeId) async {
    YunRspData<ThemeVo> rst = await YunHttp(model).get(null, "/v1/api/theme/${themeId.toString()}", null);

    return rst?.data;
  }

  static Future<YunBaseMapModel> deleteTheme<N extends YunPageBaseNotiModel>(N model, int themeId) async {
    YunRspData<YunBaseMapModel> rst =
        await YunHttp(model).delete(YunBaseMapModel(), "/v1/api/theme/${themeId.toString()}");

    return rst?.data;
  }

  static Future<YunBaseMapModel> saveTheme<N extends YunPageBaseNotiModel>(N model, data) async {
    YunRspData<YunBaseMapModel> rst = await YunHttp(model).post(YunBaseMapModel(), "/v1/api/theme", data, null);

    return rst?.data;
  }

  /// 获取主题数据列表
  static Future<List<TagDataVo>> getTagDataList<N extends YunPageBaseNotiModel>(
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

    YunRspData<TagDataVo> rst = await YunHttp(model).get(null, "/v1/api/record/data/list", qP, dIsList: true);

    return rst?.dataList;
  }

  static Future<YunBaseMapModel> saveThemeData<N extends YunPageBaseNotiModel>(N model, data) async {
    YunRspData<YunBaseMapModel> rst = await YunHttp(model).post(YunBaseMapModel(), "/v1/api/themeTagData", data, null);

    return rst?.data;
  }

  /// 获取主题详情
  static Future<ThemeVo> getThemeShare<N extends YunPageBaseNotiModel>(N model, int themeId) async {
    YunRspData<ThemeVo> rst =
        await YunHttp(model).get(null, "/v1/api/themeShare/themeShareList/${themeId.toString()}", null);

    return rst?.data;
  }

  static Future<YunBaseMapModel> deleteThemeShare<N extends YunPageBaseNotiModel>(N model, int themeId) async {
    YunRspData<YunBaseMapModel> rst =
        await YunHttp(model).delete(YunBaseMapModel(), "/v1/api/themeShare/${themeId.toString()}");

    return rst?.data;
  }

  static Future<List<SelUserVo>> getThemeAddUserList<N extends YunPageBaseNotiModel>(
      N model, int themeId, String name) async {
    var qP = Map<String, dynamic>();
    if (YunValue.hasContent(name)) {
      qP['name'] = name;
    }

    YunRspData<SelUserVo> rst =
        await YunHttp(model).get(null, "/v1/api/themeShare/addUserList/${themeId.toString()}", qP, dIsList: true);

    return rst?.dataList;
  }

  static Future<YunBaseMapModel> addUserList<N extends YunPageBaseNotiModel>(N model, int themeId, IdsDto dto) async {
    YunRspData<YunBaseMapModel> rst = await YunHttp(model)
        .post(YunBaseMapModel(), "/v1/api/themeShare/userList/${themeId.toString()}", dto.toJson(), null);

    return rst?.data;
  }
}
