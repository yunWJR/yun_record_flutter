import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/custom_vo.dart';
import 'package:yun_record/api/http_api.dart';

class CustomListModel extends YunPageBaseNotiModel {
  CustomListModel(BuildContext context) : super(context, initLoadData: true);

  List<CustomVo> customList;

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // 获取主题列表
      customList = await Api.getCustomList(this, null);

      // 错误
      if (customList == null) {
        return;
      }

      notifyListeners();
    }
  }

  Future loadList([BuildContext context]) async {
    startLoading();

    // 获取主题列表
    customList = await Api.getCustomList(this, null);

    // 错误
    if (customList == null) {
      return;
    }

    notifyListeners();
  }
}
