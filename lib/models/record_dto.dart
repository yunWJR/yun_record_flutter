import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yun_base/util/yun_date.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/prop_data_type.dart';
import 'package:yun_record/models/theme_vo.dart';

class RecordDto {
  int id; // 0

  int dateTime; // 0
  String date;
  String time;

  int tagId; // 0

  List<PropDto> propList;

  // 临时变量
  DateTime selDate;

  static RecordDto ofNew(ThemeVo theme, Tag tag, DateTime date) {
    RecordDto dto = RecordDto();
    dto.tagId = tag.id;

    String y = YunDate.ymdStr(date);
    String t = YunDate.hmsStr(date);
    dto.selDate = YunDate.ymdHmsDate("${y} ${t}");

    dto.propList = List();
    bool isFirst = true;
    for (var value in tag.propList) {
      PropDto pDto = PropDto.ofNew(value, isFirst);

      YunLog.logData(pDto.toJson());

      dto.propList.add(pDto);

      isFirst = false;
    }

    return dto;
  }

  String checkAndReform() {
    bool valid = false;
    for (var prop in propList) {
      if (prop.checkAndReform()) {
        valid = true;
      }
    }

    if (!valid) {
      return "请至少输入一项内容。";
    }

    dateTime = selDate.millisecondsSinceEpoch;

    return null;
  }

  RecordDto(
      {this.date,
      this.dateTime,
      this.id,
      this.propList,
      this.tagId,
      this.time});

  RecordDto fromJson(Map<String, dynamic> json) {
    return RecordDto(
      date: json['date'],
      dateTime: json['dateTime'],
      id: json['id'],
      propList: json['propList'] != null
          ? (json['propList'] as List)
              .map((i) => PropDto().fromJson(i))
              .toList()
          : null,
      tagId: json['tagId'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['dateTime'] = this.dateTime;
    data['id'] = this.id;
    data['tagId'] = this.tagId;
    data['time'] = this.time;
    if (this.propList != null) {
      data['propList'] = this.propList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PropDto {
  int id; // 0

  int propId; // 0

  int dataType; // 0
  String dataValue;

  // 临时变量
  Prop prop;

  TextEditingController input = TextEditingController();
  TextField nameTf;

  bool isFirst = false;

  static PropDto ofNew(Prop prop, bool isFirst) {
    PropDto dto = PropDto();

    dto.isFirst = isFirst;
    dto.propId = prop.id;
    dto.dataType = prop.dataType;

    dto.prop = prop;

    dto.input = TextEditingController();
    dto.nameTf = TextField(
      autofocus: isFirst,
      controller: dto.input,
      decoration: InputDecoration(hintText: "请输入内容", filled: true),
      keyboardType: DataTypeUtil.inputOfType(dto.dataType),
    );

    return dto;
  }

  bool checkAndReform() {
    if (YunValue.hasContent(input.text)) {
      dataValue = input.text;
      return true;
    }

    dataValue = null;
    return false;
  }

  PropDto({this.dataType, this.dataValue, this.id, this.propId});

  PropDto fromJson(Map<String, dynamic> json) {
    return PropDto(
      dataType: json['dataType'],
      dataValue: json['dataValue'],
      id: json['id'],
      propId: json['propId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataType'] = this.dataType;
    data['dataValue'] = this.dataValue;
    data['id'] = this.id;
    data['propId'] = this.propId;
    return data;
  }
}
