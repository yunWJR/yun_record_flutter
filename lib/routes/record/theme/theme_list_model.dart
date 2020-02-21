import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/models/http_api.dart';
import 'package:yun_record/models/theme_vo.dart';

class ThemeListModel extends YunPageBaseNotiModel {
  ThemeListModel(BuildContext context, List<ThemeVo> themeList) : super(context, initLoadData: (themeList == null)) {
    this.themeList = themeList;
  }

  List<ThemeVo> themeList;

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      themeList = await Api.getThemeList(this, null);
      print(themeList);

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
    themeList = await Api.getThemeList(this, null);
    print(themeList);

    // 错误
    if (themeList == null) {
      return;
    }

    notifyListeners();
  }
}
