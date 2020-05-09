import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/api/http_api.dart';
import 'package:yun_record/api/theme_api.dart';
import 'package:yun_record/models/plan_vo.dart';
import 'package:yun_record/models/theme_vo.dart';

class PlanEditModel extends YunPageBaseNotiModel {
  PlanEditModel(BuildContext context) : super(context, initLoadData: true);

  List<ThemeVo> themeList;
  int selThemeIndex;

  /// dto
  PlanVo dto = PlanVo.dto();

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      themeList = await ThemeApi.getThemeList(this, null);

      // 错误
      if (themeList == null) {
        return;
      }

//      dto = PlanVo.dto();

      if (themeList.length > 0) {
        selThemeIndex = 0;
        dto.themeId = themeList[selThemeIndex].id;
        dto.theme = themeList[selThemeIndex];
      }

      notifyListeners();
    }
  }

  Future<bool> savePlan([BuildContext context]) async {
    startLoading();

    bool suc = checkAndReformDto();
    if (!suc) {
      return false;
    }

    var rst = await Api.savePlan(this, dto.toJson());

    return rst != null;
  }

  bool checkAndReformDto() {
    String err = dto.checkAndReform();

    if (err != null) {
      showErr(err);
      return false;
    }

    return true;
  }

  String selThemeName() {
    if (dto == null || dto.theme == null) {
      return "";
    }

    return dto.theme.nameWithType();
  }

  void updateSelThemeIndex(int index) {
    if (selThemeIndex != index && index < themeList.length) {
      selThemeIndex = index;
      dto.themeId = themeList[selThemeIndex].id;
      dto.theme = themeList[selThemeIndex];

      notifyListeners();
    }
  }
}
