import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/api/http_api.dart';
import 'package:yun_record/models/user_vo.dart';

class MyModel extends YunPageBaseNotiModel {
  MyModel(BuildContext context) : super(context, initLoadData: true);

  UserVo userVo = new UserVo();

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      userVo = await Api.getUserInfo(this);

      // 错误
      if (userVo == null) {
        return;
      }

      notifyListeners();
    }
  }
}
