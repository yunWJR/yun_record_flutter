import 'package:flutter/material.dart';
import 'package:yun_record/api/theme_api.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/theme_vo.dart';

class SelectThemeModel extends YunPageBaseNotiModel {
  SelectThemeModel(BuildContext context, int selIndex) : super(context, initLoadData: true) {
    this.selIndex = selIndex;
  }

  int selIndex = 0;

  List<ThemeVo> themeList = [];

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      themeList = await ThemeApi.getThemeList(this, null);

      // 错误
      if (themeList == null) {
        return;
      }

      if (selIndex == null || selIndex < 0 || selIndex >= themeList.length) {
        selIndex = 0;
      }

      notifyListeners();
    }
  }

  String selName() {
    if (hasTheme()) {
      return themeList[selIndex].name;
    } else {
      return "无主题";
    }
  }

  bool hasTheme() {
    return themeList != null && themeList.length > 0;
  }

  void updateIndex(int index) {
    if (index != selIndex) {
      selIndex = index;
      notifyListeners();
    }
  }
}
