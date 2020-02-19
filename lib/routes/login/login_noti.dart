import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';

class LoginNoti extends YunPageBaseNotiModel {
  LoginNoti(BuildContext context) : super(context, initLoadData: false) {
//    initLoadData = false;
  }

  @override
  Future loadData([BuildContext context]) async {
    if (canLoadData()) {
      // Add parsed item

      await Future.delayed(Duration(milliseconds: 1000));

      finishLoading();
    }
  }

  Future login([BuildContext context]) async {
    if (canLoadData()) {
      // Add parsed item

      await Future.delayed(Duration(milliseconds: 1000));

      finishLoading();
    }
  }
}
