import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yun_record/common/model/YunPageBaseNotiModel.dart';
import 'package:yun_record/models/RecordDto.dart';
import 'package:yun_record/models/Api.dart';
import 'package:yun_record/models/ThemeVo.dart';

class AddRecordModel extends YunPageBaseNotiModel {
  AddRecordModel(BuildContext context) : super(context, initLoadData: false);

  ThemeVo _theme;
  Tag _tag;
  DateTime _date;

  // dto
  RecordDto dto = RecordDto();

  @override
  Future loadData([BuildContext context]) async {}

  Future<bool> saveRecord([BuildContext context]) async {
    startLoading();

    bool suc = checkAndReformDto();
    if (!suc) {
      // todo
      return false;
    }

    var rst = await Api.saveThemeData(this, dto.toJson());

    return rst != null;
  }

  void setArgu(Map<String, dynamic> argu) {
    this._theme = argu['theme'];
    this._tag = argu['tag'];
    this._date = argu['date'];

    // todo 新建
    dto = RecordDto.ofNew(_theme, _tag, _date);
  }

  String timeText() {
    return DateFormat("HH:mm:ss").format(dto.selDate);
  }

  void updateTime(DateTime date) {
    if (date != dto.selDate) {
      dto.selDate = date;

      notifyListeners();
    }
  }

  bool checkAndReformDto() {
    String err = dto.checkAndReform();

    if (err != null) {
      showErr(err);
      return false;
    }

    return true;
  }
}
