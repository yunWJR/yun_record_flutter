import 'package:yun_base/model/yun_base_model.dart';

import 'custom_vo.dart';

class CustomDataVo extends YunBaseModel {
  int createTime; // 0
  Custom custom;
  int dataType; // 0
  String date;
  int dateTime; // 0
  int id; // 0
  int status; // 0
  String time;

  CustomDataVo(
      {this.createTime, this.custom, this.dataType, this.date, this.dateTime, this.id, this.status, this.time});

  factory CustomDataVo.fromJson(Map<String, dynamic> json) {
    return CustomDataVo(
      createTime: json['createTime'],
      custom: json['custom'] != null ? Custom.fromJson(json['custom']) : null,
      dataType: json['dataType'],
      date: json['date'],
      dateTime: json['dateTime'],
      id: json['id'],
      status: json['status'],
      time: json['time'],
    );
  }

  fromJson(Map<String, dynamic> json) {
    return CustomDataVo(
      createTime: json['createTime'],
      custom: json['custom'] != null ? Custom.fromJson(json['custom']) : null,
      dataType: json['dataType'],
      date: json['date'],
      dateTime: json['dateTime'],
      id: json['id'],
      status: json['status'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['dataType'] = this.dataType;
    data['date'] = this.date;
    data['dateTime'] = this.dateTime;
    data['id'] = this.id;
    data['status'] = this.status;
    data['time'] = this.time;
    if (this.custom != null) {
      data['custom'] = this.custom.toJson();
    }
    return data;
  }

  isCmp() {
    if (status != null) {
      return status == 3;
    }

    return false;
  }
}
