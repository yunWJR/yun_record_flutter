import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/api/http_api.dart';
import 'package:yun_record/api/record_api.dart';
import 'package:yun_record/models/TagVo.dart';
import 'package:yun_record/models/theme_vo.dart';

class AddTagModel extends YunPageBaseNotiModel {
  AddTagModel(BuildContext context, List<ThemeVo> themeList) : super(context, initLoadData: false) {
    this.themeList = themeList;
    if (tagDto == null) {
      tagDto = TagVo.dto();
    }

    if (themeList != null && themeList.length > 0) {
      tagDto.themeId = themeList[0].id;
    }
  }

  List<ThemeVo> themeList = [];

  TagVo tagDto = TagVo.dto();

  @override
  Future loadData([BuildContext context]) async {}

  Future<bool> createThemeByTemplate(int tempId, String name) async {
    startLoading();
    Map<String, dynamic> data = {};

    data["templateId"] = tempId;
    data["themeName"] = name;

    var rst = await Api.createThemeByTemplate(this, data);

    return rst != null;
  }

  bool valid() {
    return tagDto.valid((String errMsg) {
      if (YunValue.hasContent(errMsg)) {
        showErr(errMsg);
      }
    });
  }

  Future<bool> saveTag() async {
    startLoading();

    tagDto.getData();

    var rst = await RecordApi.saveRecord(this, tagDto.toJson());

    return rst != null;
  }
}
