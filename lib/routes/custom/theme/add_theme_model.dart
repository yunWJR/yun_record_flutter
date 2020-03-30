import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/models/http_api.dart';
import 'package:yun_record/models/theme_temp_vo.dart';

class AddTempThemeModel extends YunPageBaseNotiModel {
  AddTempThemeModel(BuildContext context, ThemeTempVo tmpVo) : super(context, initLoadData: false) {
    this.tmpVo = tmpVo;

    if (tmpVo != null && tmpVo.id != null) {
      loadData(context);
    }
  }

  ThemeTempVo tmpVo;

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      print('loadData');
      print(tmpVo);
      // 获取主题列表
      if (tmpVo != null && tmpVo.id != null) {
        tmpVo = await Api.getThemeTempDetails(this, tmpVo.id);
      }

      // 错误
      if (tmpVo == null) {
        return;
      }

      notifyListeners();
    }
  }

  Future<bool> createThemeByTemplate(int tempId, String name) async {
    startLoading();
    Map<String, dynamic> data = {};

    data["templateId"] = tempId;
    data["themeName"] = name;

    var rst = await Api.createThemeByTemplate(this, data);

    return rst != null;
  }
}
