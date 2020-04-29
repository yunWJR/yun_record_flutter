import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/api/http_api.dart';
import 'package:yun_record/models/theme_temp_vo.dart';

class ThemeTempModel extends YunPageBaseNotiModel {
  ThemeTempModel(BuildContext context) : super(context) {}

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
