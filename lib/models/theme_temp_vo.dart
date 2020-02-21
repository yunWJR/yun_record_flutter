import 'package:yun_base/model/yun_base_model.dart';
import 'package:yun_base/util/yun_value.dart';

class ThemeTempVo implements YunBaseModel {
  int createTime; // 0
  int id; // 0
  String name;
  String remark;
  List<Tag> tagList;
  TempType type; // 0
  int typeId; // 0

  ThemeTempVo({this.createTime, this.id, this.name, this.remark, this.tagList, this.type, this.typeId});

  ThemeTempVo fromJson(Map<String, dynamic> json) {
    return ThemeTempVo(
      createTime: json['createTime'],
      id: json['id'],
      name: json['name'],
      remark: json['remark'],
      tagList: json['tagList'] != null ? (json['tagList'] as List).map((i) => Tag().fromJson(i)).toList() : null,
      type: TempType().fromJson(json['type']),
      typeId: json['typeId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['type'] = this.type.toJson();
    data['typeId'] = this.typeId;
    if (this.tagList != null) {
      data['tagList'] = this.tagList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tag implements YunBaseModel {
  int createTime; // 0
  int id; // 0
  String name;
  List<Prop> propList;
  String remark;

  Tag({this.createTime, this.id, this.name, this.propList, this.remark});

  Tag fromJson(Map<String, dynamic> json) {
    return Tag(
      createTime: json['createTime'],
      id: json['id'],
      name: json['name'],
      propList: json['propList'] != null ? (json['propList'] as List).map((i) => Prop().fromJson(i)).toList() : null,
      remark: json['remark'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['name'] = this.name;
    data['remark'] = this.remark;
    if (this.propList != null) {
      data['propList'] = this.propList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prop implements YunBaseModel {
  int createTime; // 0
  int dataType; // 0
  int dataTypeId; // 0
  String dataUnit;
  int id; // 0
  String name;

  Prop({this.createTime, this.dataType, this.dataTypeId, this.dataUnit, this.id, this.name});

  Prop fromJson(Map<String, dynamic> json) {
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

  String dataUnitName() {
    return YunValue.hasContent(dataUnit) ? dataUnit : "无";
  }
}

class TempType {
  int createTime; // 1579229261930
  int creatorId; // 5
  int id; // 1
  String name; // 通用模板
  String remark;
  int type; // 1
  int updateTime; // 1579229261930

  TempType({this.createTime, this.creatorId, this.id, this.name, this.remark, this.type, this.updateTime});

  TempType fromJson(Map<String, dynamic> json) {
    return TempType(
      createTime: json['createTime'],
      creatorId: json['creatorId'],
      id: json['id'],
      name: json['name'],
      remark: json['remark'],
      type: json['type'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['creatorId'] = this.creatorId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['type'] = this.type;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
