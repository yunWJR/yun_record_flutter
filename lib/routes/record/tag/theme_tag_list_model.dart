import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/api/theme_api.dart';
import 'package:yun_record/models/theme_vo.dart';

class ThemeTagListModel extends YunPageBaseNotiModel {
  ThemeTagListModel(BuildContext context, List<ThemeVo> themeList) : super(context, initLoadData: true) {
    this.themeList = themeList;
  }

  List<ThemeVo> themeList;

  bool isExpandAll = false;

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      themeList = await ThemeApi.getThemeTagList(this, null, null);

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
    themeList = await ThemeApi.getThemeTagList(this, null, null);

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

  void changeThemeExpand(ThemeVo theme) {
    theme.isExpand = !theme.isExpand;

    // 全部判断
    int negCount = 0;

    for (var item in themeList) {
      if (item.isExpand != isExpandAll) {
        negCount++;
      } else {
        break;
      }
    }

    if (negCount == themeList.length) {
      isExpandAll = !isExpandAll;
    }

    notifyListeners();
  }

  void changeExpandAll() {
    isExpandAll = !isExpandAll;

    for (var value in themeList) {
      value.isExpand = isExpandAll;
    }

    notifyListeners();
  }
}
