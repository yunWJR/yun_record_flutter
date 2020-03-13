import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/models/http_api.dart';
import 'package:yun_record/models/plan_vo.dart';

class PlanEditModel extends YunPageBaseNotiModel {
  PlanEditModel(BuildContext context) : super(context, initLoadData: false);

  /// dto
  PlanVo dto = PlanVo.dto();

  @override
  Future loadData([BuildContext context]) async {}

  Future<bool> savePlan([BuildContext context]) async {
    startLoading();

    bool suc = checkAndReformDto();
    if (!suc) {
      return false;
    }

    var rst = await Api.savePlan(this, dto.toJson());

    return rst != null;
  }

//  String timeText() {
//    return DateFormat("HH:mm:ss").format(dto.selDate);
//  }

//  void updateTime(DateTime date) {
//    if (date != dto.selDate) {
//      dto.selDate = date;
//
//      notifyListeners();
//    }
//  }

  bool checkAndReformDto() {
    String err = dto.checkAndReform();

    if (err != null) {
      showErr(err);
      return false;
    }

    return true;
  }
}
