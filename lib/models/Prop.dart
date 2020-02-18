import 'package:yun_base/model/YunBaseModel.dart';

class Prop implements YunBaseModel {
  int createTime; // 0
  int dataType; // 0
  int dataTypeId; // 0
  String dataUnit;
  int id; // 0
  String name;

  Prop({this.createTime, this.dataType, this.dataTypeId, this.dataUnit, this.id, this.name});

  fromJson(Map<String, dynamic> json) {
    return Prop(
      createTime: json['createTime'],
      dataType: json['dataType'],
      dataTypeId: json['dataTypeId'],
      dataUnit: json['dataUnit'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['dataType'] = this.dataType;
    data['dataTypeId'] = this.dataTypeId;
    data['dataUnit'] = this.dataUnit;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
