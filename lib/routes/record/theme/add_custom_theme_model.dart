import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/models/http_api.dart';
import 'package:yun_record/models/theme_vo.dart';

class AddCustomThemeModel extends YunPageBaseNotiModel {
  AddCustomThemeModel(BuildContext context) : super(context, initLoadData: false) {}

  ThemeVo themeDto = ThemeVo.dto();

  @override
  Future loadData([BuildContext context]) async {}

  Future<bool> createThemeByTemplate(int tempId, String name) async {
    startLoading();
    Map<String, dynamic> data = {};

    data["templateId"] = tempId;
    data["themeName"] = name;

    var rst = await Api.createThemeByTemplate(this, data);

    return rst != null;
  }
}
