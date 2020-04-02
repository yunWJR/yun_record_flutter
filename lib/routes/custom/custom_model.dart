import 'package:flutter/material.dart';
import 'package:yun_base/log/yun_log.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/util/yun_date.dart';
import 'package:yun_record/models/custom_data_vo.dart';
import 'package:yun_record/models/custom_record_data_dto.dart';
import 'package:yun_record/models/http_api.dart';

class CustomModel extends YunPageBaseNotiModel {
  CustomModel(BuildContext context) : super(context) {
  }

  List<CustomDataVo> customDataList;

  bool isToday = true;
  DateTime selDate;

  @override
  Future loadData([BuildContext context]) async {
    await loadList(context);
  }

  DateTime _curDate() {
    if (isToday) {
      selDate = DateTime.now();
    }

    return selDate;
  }

  Future loadList([BuildContext context]) async {
    if (canLoadData()) {
      // Add parsed item

      String date = YunDate.ymdStr(_curDate());

      customDataList = await Api.getCustomDataList(this, date);
      // 错误
      if (customDataList == null) {
        return;
      }

      notifyListeners();
    }
  }

  bool isBlankList() {
    if (customDataList == null || customDataList.length == 0) {
      return true;
    }

    return false;
  }

  String dateText() {
    if (_curDate() != null) {
      return YunDate.ymdStr(_curDate());
    }

    return "请选择日期";
  }

  void selectDate(DateTime date) {
    if (isToday == true || !YunDate.sameYmd(selDate, date)) {
      isToday = false;
      selDate = date;

      loadList();
    }
  }

  Future itemOn(CustomDataVo item) async {
    if (item.isCmp()) {
//      return;
    }

    if (canLoadData()) {
      CustomRecordDataDto dto = CustomRecordDataDto.newItem(item);

      var rst = await Api.saveCustomRecordData(this, dto);

      if (rst == null) {
        return;
      }

      String date = YunDate.ymdStr(_curDate());

      customDataList = await Api.getCustomDataList(this, date);
      // 错误
      if (customDataList == null) {
        return;
      }

      notifyListeners();
    }
  }
}
