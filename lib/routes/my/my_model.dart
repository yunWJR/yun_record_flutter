import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/models/http_api.dart';
import 'package:yun_record/models/record_dto.dart';
import 'package:yun_record/models/theme_vo.dart';

class MyModel extends YunPageBaseNotiModel {
  MyModel(BuildContext context) : super(context, initLoadData: false);

  @override
  Future loadData([BuildContext context]) async {}
}
