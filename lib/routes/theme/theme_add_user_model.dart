import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/api/theme_api.dart';
import 'package:yun_record/models/IdsDto.dart';
import 'package:yun_record/models/sel_user_vo.dart';
import 'package:yun_record/models/theme_vo.dart';

class ThemeAddUserModel extends YunPageBaseNotiModel {
  ThemeAddUserModel(BuildContext context, ThemeVo theme) : super(context, initLoadData: false) {
    this.themeId = theme?.id;
    loadData();
  }

  int themeId;

  List<SelUserVo> userList;

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      userList = await ThemeApi.getThemeAddUserList(this, themeId, null);

      // 错误
      if (userList == null) {
        return;
      }

      notifyListeners();
    }
  }

  void userSelOn(int userIndex) {
    userList[userIndex].selected = !userList[userIndex].selected;
    notifyListeners();
  }

  Future<bool> addUser() async {
    startLoading();

    IdsDto dto = IdsDto();
    dto.ids = [];
    for (var value in userList) {
      if (value.selected) {
        dto.ids.add(value.id);
      }
    }
    ;

    if (dto.ids.length == 0) {
      finishLoading();
      showErr("请选择用户");
      await Future.delayed(Duration());
      return false;
    }

    var rst = await ThemeApi.addUserList(this, themeId, dto);

    return rst != null;
  }
}
