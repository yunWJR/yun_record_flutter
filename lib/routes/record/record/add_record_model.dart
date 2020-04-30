import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_record/api/http_api.dart';
import 'package:yun_record/api/record_api.dart';
import 'package:yun_record/models/TagVo.dart';
import 'package:yun_record/models/record_dto.dart';
import 'package:yun_record/models/theme_vo.dart';

class AddRecordModel extends YunPageBaseNotiModel {
  AddRecordModel(BuildContext context) : super(context, initLoadData: false);

  ThemeVo _theme;
  TagVo _tag;
  DateTime _date;

  /// dto
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

    var rst = await RecordApi.saveRecordData(this, dto.toJson());

    return rst != null;
  }

  void setArgu(Map<String, dynamic> argu) {
    this._theme = argu['theme'];
    this._tag = argu['tag'];
    this._date = argu['date'];

    // todo 新建
    dto = RecordDto.ofNew(_theme, _tag, _date);
  }

  String dateTimeText() {
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(dto.selDate);
  }

  String timeText() {
    return DateFormat("HH:mm:ss").format(dto.selDate);
  }

  void updateDate(DateTime date) {
    if (date != dto.selDate) {
      dto.selDate = date;

      notifyListeners();
    }
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
