import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/api/http_api.dart';
import 'package:yun_record/api/theme_api.dart';
import 'package:yun_record/models/theme_vo.dart';

class ThemeListModel extends YunPageBaseNotiModel {
  ThemeListModel(BuildContext context, List<ThemeVo> themeList) : super(context, initLoadData: true) {
    this.themeList = themeList;
  }

  List<ThemeVo> themeList;

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      themeList = await ThemeApi.getThemeList(this, null);

      // 错误
      if (themeList == null) {
        return;
      }

      notifyListeners();
    }
  }

  Future loadList([BuildContext context]) async {
    startLoading();

    // 获取主题列表
    themeList = await ThemeApi.getThemeList(this, null);

    // 错误
    if (themeList == null) {
      return;
    }

    notifyListeners();
  }

  Future deleteTheme(int id) async {
    startLoading();

    // 获取主题列表
    var rst = await ThemeApi.deleteTheme(this, id);

    // 错误
    if (rst == null) {
      return;
    }

    loadList();
  }
}
