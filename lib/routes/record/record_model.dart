import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/util/yun_date.dart';
import 'package:yun_record/models/http_api.dart';
import 'package:yun_record/models/theme_data_vo.dart';
import 'package:yun_record/models/theme_vo.dart';

class RecordModel extends YunPageBaseNotiModel {
  RecordModel(BuildContext context) : super(context) {
    this.selDate = DateTime.now();
  }

  List<ThemeVo> themeList;
  List<ThemeDataVo> themeDataList;

  ThemeVo selTheme;

  ThemeVo selThemeDt;

  DateTime selDate;

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      themeList = await Api.getThemeList(this, null);

      // 错误
      if (themeList == null) {
        return;
      }

      if (themeList.length == 0) {
        // 自动隐藏加载框
        showErr("主题不存在，请添加主题");
        return;
      }

//      // todo 选中项，可以缓存本地
//      if (selTheme == null) {
//        selTheme = themeList[0];
//      }

      if (selDate == null) {
        selDate = DateTime.now();
      }

      String date = YunDate.ymdStr(selDate);

      themeDataList = await Api.getThemeDataList(this, date, null, selTheme?.id);

      notifyListeners();
    }
  }

  Future loadList([BuildContext context]) async {
    if (canLoadData()) {
      String date = YunDate.ymdStr(selDate);

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

    return "全部主题";
  }

  String dateText() {
    if (selDate != null) {
      return YunDate.ymdStr(selDate);
    }

    return "请选择日期";
  }

  void selectTheme(int themeId) {
    // todo null
    if (themeId == null) {
      if (selTheme != null) {
        selTheme = null;
        loadList();
        return;
      }

      return;
    }

    if (selTheme == null || selTheme.id != themeId) {
      for (var value in themeList) {
        if (value.id == themeId) {
          selTheme = value;
          break;
        }
      }

      loadList();
    }
  }

  bool isSelTheme(int themeId) {
    if (themeId == null) {
      return selTheme == null;
    }

    if (selTheme == null) {
      return false;
    }

    return selTheme.id == themeId;
  }

  void selectDate(DateTime date) {
    if (selTheme == null || !YunDate.sameYmd(selDate, date)) {
      selDate = date;

      loadList();
    }
  }

  Future<ThemeVo> getValidThemeDetails(ThemeVo selTheme) async {
    if (selTheme == null) {
      await Future.delayed(Duration(microseconds: 0));
      if (selThemeDt.tagList.length == 0) {
        showErr("主题无标签信息");
      }

      return null;
    }

    if (selThemeDt == null || selThemeDt.id != selTheme.id) {
      selThemeDt = await Api.getThemeDetails(this, selTheme.id);
    }

    return selThemeDt;
  }
}
