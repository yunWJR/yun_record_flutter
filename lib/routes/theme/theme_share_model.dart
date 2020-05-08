import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/api/theme_api.dart';
import 'package:yun_record/models/ThemeShareItemVo.dart';
import 'package:yun_record/models/theme_vo.dart';

class ThemeShareModel extends YunPageBaseNotiModel {
  ThemeShareModel(BuildContext context, ThemeVo themeVo) : super(context, initLoadData: false) {
    this.themeId = themeVo?.id;
    loadData();
  }

  int themeId;

  ThemeVo themeVo;

  List<ThemeShareItemVo> itemList;

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取数据
      themeVo = await ThemeApi.getThemeShare(this, themeId);

      // 错误
      if (themeVo == null) {
        return;
      }

      itemList = themeVo.shareList;

      notifyListeners();
    }
  }

  Future deleteShareItem(int id) async {
    startLoading();

    // 删除
    var rst = await ThemeApi.deleteThemeShare(this, id);

    // 错误
    if (rst == null) {
      return;
    }

    loadData();
  }

  void changeThemeExpand(ThemeVo theme) {
    theme.isExpand = !theme.isExpand;
    notifyListeners();
  }
}
