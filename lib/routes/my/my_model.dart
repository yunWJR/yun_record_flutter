import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';

class MyModel extends YunPageBaseNotiModel {
  MyModel(BuildContext context) : super(context, initLoadData: false);

  @override
  Future loadData([BuildContext context]) async {
    await Future.delayed(Duration.zero);

    return null;
  }
}
