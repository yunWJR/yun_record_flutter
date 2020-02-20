import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/models/http_api.dart';
import 'package:yun_record/models/theme_temp_vo.dart';
import 'package:yun_record/models/theme_vo.dart';

class AddThemeModel extends YunPageBaseNotiModel {
  AddThemeModel(BuildContext context) : super(context) {}

  List<ThemeTempVo> themeTempList = [];

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      themeTempList = await Api.getThemeTempList(this, null);

      // 错误
      if (themeTempList == null) {
        return;
      }

      notifyListeners();
    }
  }
}
