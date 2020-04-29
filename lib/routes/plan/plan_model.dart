import 'package:flutter/material.dart';
import 'package:yun_base/log/yun_log.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/api/http_api.dart';
import 'package:yun_record/models/plan_vo.dart';

class PlanModel extends YunPageBaseNotiModel {
  PlanModel(BuildContext context) : super(context) {
  }

  List<PlanVo> planList;

  // 1- 完成状态，创建时间；2-创建时间;
  int sortType = 1;

  // 0-默认所有 1-只显示未完成 2-只显示已完成
  int showType = 0;

  @override
  Future loadData([BuildContext context]) async {
    await loadList();
  }

  Future loadList([BuildContext context]) async {
    if (canLoadData()) {
      planList = await Api.getPlanList(this, null, sortType: sortType, showType: showType);

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

      planList = await Api.getPlanList(this, null, sortType: sortType, showType: showType);

      if (planList == null) {
        return;
      }

      notifyListeners();
    }
  }

  void changeSortType() {
    if (sortType == 1) {
      sortType = 2;
    } else {
      sortType = 1;
    }

    loadList();
  }
}
