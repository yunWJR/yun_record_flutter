import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yun_record/common/model/PageBaseNotiModel.dart';
import 'package:yun_record/common/util/DateUtils.dart';
import 'package:yun_record/models/Api.dart';
import 'package:yun_record/models/ThemeDataVo.dart';
import 'package:yun_record/models/ThemeVo.dart';

class HomeModel extends PageBaseNotiModel {
  HomeModel(BuildContext context) : super(context);

  List<ThemeVo> themeList;
  List<ThemeDataVo> themeDataList;

  ThemeVo selTheme;

  DateTime selDate;

  @override
  Future loadData([BuildContext context]) async {
    if (await canLoadData()) {
      // 获取主题列表
      themeList = await Api.getThemeList(this, null);

      // 错误
      if (themeList == null) {
        return;
      }

      if (themeList.length == 0) {
        finishLoading();
        showErr("主题不存在，请添加主题");
        return;
      }

      // todo 选中项，可以缓存本地
      selTheme = themeList[0];

      if (selDate == null) {
//        selDate = DateTime.now();
      }

      String date = DateUtils.dayStr(selDate);

      themeDataList = await Api.getThemeDataList(this, date, null, selTheme?.id);

      notifyListeners();
    }
  }

  bool isBlankList() {
    if (themeDataList == null || themeDataList.length == 0) {
      return true;
    }

    return false;
  }

  String themeText() {
    if (selTheme != null) {
      return selTheme.name;
    }

    return "请选择主题";
  }

  String dateText() {
    if (selDate != null) {
      return DateUtils.dayStr(selDate);
    }

    return "请选择日期";
  }
}
