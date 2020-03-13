import 'package:flutter/material.dart';
import 'package:yun_base/log/yun_log.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/models/http_api.dart';
import 'package:yun_record/models/plan_vo.dart';

class PlanModel extends YunPageBaseNotiModel {
  PlanModel(BuildContext context) : super(context) {
    YunLog.logData('PlanModel inti');
  }

  List<PlanVo> planList;

  @override
  Future loadData([BuildContext context]) async {
    await loadList();
  }

  Future loadList([BuildContext context]) async {
    if (canLoadData()) {
      planList = await Api.getPlanList(this, null);

      if (planList == null) {
        return;
      }

      notifyListeners();
    }
  }

  bool isBlankList() {
    if (planList == null || planList.length == 0) {
      return true;
    }

    return false;
  }

  Future changeItemStatus(PlanVo item) async {
    if (canLoadData()) {
      int status = item.isCmp() ? 0 : 1;

      var rst = await Api.savePlanStatus(this, item.id, status);

      if (rst == null) {
        return;
      }

      planList = await Api.getPlanList(this, null);

      if (planList == null) {
        return;
      }

      notifyListeners();
    }
  }
}
