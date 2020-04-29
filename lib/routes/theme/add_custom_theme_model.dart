import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/api/http_api.dart';
import 'package:yun_record/models/theme_vo.dart';

class AddCustomThemeModel extends YunPageBaseNotiModel {
  AddCustomThemeModel(BuildContext context) : super(context, initLoadData: false) {
    if (themeDto == null) {
      themeDto = ThemeVo.dto();
    }
  }

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

  bool valid() {
    return themeDto.valid((String errMsg) {
      if (YunValue.hasContent(errMsg)) {
        showErr(errMsg);
      }
    });
  }

  Future<bool> saveTheme() async {
    startLoading();

    themeDto.getData();

    print(themeDto.toJson());
    var rst = await Api.saveCustomTheme(this, themeDto.toJson());

    return rst != null;
  }
}
