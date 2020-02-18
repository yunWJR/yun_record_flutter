import 'package:yun_record/common/model/YunBaseModel.dart';

class ThemeVo implements YunBaseModel {
  int createTime; // 0
  int id; // 0
  String name;
  String remark;
  List<Tag> tagList;

  ThemeVo({this.createTime, this.id, this.name, this.remark, this.tagList});

  ThemeVo fromJson(Map<String, dynamic> json) {
    ThemeVo vo = ThemeVo(
      createTime: json['createTime'],
      id: json['id'],
      name: json['name'],
      remark: json['remark'],
      tagList: json['tagList'] != null ? (json['tagList'] as List).map((i) => Tag().fromJson(i)).toList() : null,
    );

    return vo;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['name'] = this.name;
    data['remark'] = this.remark;
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
}
