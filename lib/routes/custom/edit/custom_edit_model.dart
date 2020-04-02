import 'package:flutter/material.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/models/custom_vo.dart';
import 'package:yun_record/models/http_api.dart';

class CustomEditModel extends YunPageBaseNotiModel {
  CustomEditModel(BuildContext context, {this.dto}) : super(context, initLoadData: false) {
    if (this.dto == null) {
      this.dto = Custom.dto();
    }
  }

  Custom dto;

  @override
  Future loadData([BuildContext context]) async {}

  Future<bool> saveCustom([BuildContext context]) async {
    startLoading();

    bool suc = checkAndReformDto();
    if (!suc) {
      return false;
    }

    var rst = await Api.saveCustom(this, dto.toJson());

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
    if (!dto.nameFormKey.currentState.validate()) {
      finishLoading();
      return false;
    }

    if (!dto.completeParaFormKey.currentState.validate()) {
      finishLoading();
      return false;
    }

    String err = dto.checkAndReform();

    if (err != null) {
      showErr(err);
      return false;
    }

    return true;
  }
}
