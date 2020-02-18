import 'package:yun_record/common/model/YunBaseModel.dart';

class ThemeDataVo implements YunBaseModel {
  int createTime; // 0
  int creatorId; // 0
  String date;
  int dateTime; // 0
  int id; // 0
  String name;
  List<PropDataVo> propDataList;
  String remark;
  int tagId; // 0
  ThemeV theme;
  int themeId; // 0
  String time;
  int updateTime; // 0
  int userId; // 0

  ThemeDataVo(
      {this.createTime,
      this.creatorId,
      this.date,
      this.dateTime,
      this.id,
      this.name,
      this.propDataList,
      this.remark,
      this.tagId,
      this.theme,
      this.themeId,
      this.time,
      this.updateTime,
      this.userId});

  ThemeDataVo fromJson(Map<String, dynamic> json) {
    return ThemeDataVo(
      createTime: json['createTime'],
      creatorId: json['creatorId'],
      date: json['date'],
      dateTime: json['dateTime'],
      id: json['id'],
      name: json['name'],
      propDataList: json['propDataList'] != null
          ? (json['propDataList'] as List).map((i) => PropDataVo().fromJson(i)).toList()
          : null,
      remark: json['remark'],
      tagId: json['tagId'],
      theme: json['theme'] != null ? ThemeV().fromJson(json['theme']) : null,
      themeId: json['themeId'],
      time: json['time'],
      updateTime: json['updateTime'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['creatorId'] = this.creatorId;
    data['date'] = this.date;
    data['dateTime'] = this.dateTime;
    data['id'] = this.id;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['tagId'] = this.tagId;
    data['themeId'] = this.themeId;
    data['time'] = this.time;
    data['updateTime'] = this.updateTime;
    data['userId'] = this.userId;
    if (this.propDataList != null) {
      data['propDataList'] = this.propDataList.map((v) => v.toJson()).toList();
    }
    if (this.theme != null) {
      data['theme'] = this.theme.toJson();
    }
    return data;
  }
}

class ThemeV implements YunBaseModel {
  int createTime; // 0
  int id; // 0
  String name;
  String remark;
  int updateTime; // 0
  int userId; // 0

  ThemeV({this.createTime, this.id, this.name, this.remark, this.updateTime, this.userId});

  ThemeV fromJson(Map<String, dynamic> json) {
    return ThemeV(
      createTime: json['createTime'],
      id: json['id'],
      name: json['name'],
      remark: json['remark'],
      updateTime: json['updateTime'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['updateTime'] = this.updateTime;
    data['userId'] = this.userId;
    return data;
  }
}

class Prop {
  int createTime; // 1578495265771
  int dataType; // 2
  int dataTypeId; // null
  String dataUnit; // ml
  int id; // 2
  String name; // 容量
  int tagId; // 5
  int themeId; // 1
  int updateTime; // 1578495265771
  int userId; // 1

  Prop(
      {this.createTime,
      this.dataType,
      this.dataTypeId,
      this.dataUnit,
      this.id,
      this.name,
      this.tagId,
      this.themeId,
      this.updateTime,
      this.userId});

  Prop fromJson(Map<String, dynamic> json) {
    return Prop(
      createTime: json['createTime'],
      dataType: json['dataType'],
      dataTypeId: json['dataTypeId'],
      dataUnit: json['dataUnit'],
      id: json['id'],
      name: json['name'],
      tagId: json['tagId'],
      themeId: json['themeId'],
      updateTime: json['updateTime'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['dataType'] = this.dataType;
    data['dataUnit'] = this.dataUnit;
    data['id'] = this.id;
    data['name'] = this.name;
    data['tagId'] = this.tagId;
    data['themeId'] = this.themeId;
    data['updateTime'] = this.updateTime;
    data['userId'] = this.userId;
    data['dataTypeId'] = this.dataTypeId;

    return data;
  }
}

class PropDataVo implements YunBaseModel {
  bool hasData; // true
  Prop prop;
  PropData propData;

  PropDataVo({this.hasData, this.prop, this.propData});

  PropDataVo fromJson(Map<String, dynamic> json) {
    return PropDataVo(
      hasData: json['hasData'],
      prop: json['prop'] != null ? Prop().fromJson(json['prop']) : null,
      propData: json['propData'] != null ? PropData().fromJson(json['propData']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasData'] = this.hasData;
    if (this.prop != null) {
      data['prop'] = this.prop.toJson();
    }
    if (this.propData != null) {
      data['propData'] = this.propData.toJson();
    }
    return data;
  }
}

class PropData implements YunBaseModel {
  int bigDecimalValue; // 0
  int createTime; // 0
  int creatorId; // 0
  int dataType; // 0
  int dataTypeId; // 0
  int doubleValue; // 0
  int enumValue; // 0
  int id; // 0
  int intValue; // 0
  String orgValue;
  int tagDataId; // 0
  int tagId; // 0
  int tagPropId; // 0
  String textValue;
  int themeId; // 0
  String timeValue;
  int updateTime; // 0
  int userId; // 0

  PropData(
      {this.bigDecimalValue,
      this.createTime,
      this.creatorId,
      this.dataType,
      this.dataTypeId,
      this.doubleValue,
      this.enumValue,
      this.id,
      this.intValue,
      this.orgValue,
      this.tagDataId,
      this.tagId,
      this.tagPropId,
      this.textValue,
      this.themeId,
      this.timeValue,
      this.updateTime,
      this.userId});

  PropData fromJson(Map<String, dynamic> json) {
    return PropData(
      bigDecimalValue: json['bigDecimalValue'],
      createTime: json['createTime'],
      creatorId: json['creatorId'],
      dataType: json['dataType'],
      dataTypeId: json['dataTypeId'],
      doubleValue: json['doubleValue'],
      enumValue: json['enumValue'],
      id: json['id'],
      intValue: json['intValue'],
      orgValue: json['orgValue'],
      tagDataId: json['tagDataId'],
      tagId: json['tagId'],
      tagPropId: json['tagPropId'],
      textValue: json['textValue'],
      themeId: json['themeId'],
      timeValue: json['timeValue'],
      updateTime: json['updateTime'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bigDecimalValue'] = this.bigDecimalValue;
    data['createTime'] = this.createTime;
    data['creatorId'] = this.creatorId;
    data['dataType'] = this.dataType;
    data['dataTypeId'] = this.dataTypeId;
    data['doubleValue'] = this.doubleValue;
    data['enumValue'] = this.enumValue;
    data['id'] = this.id;
    data['intValue'] = this.intValue;
    data['orgValue'] = this.orgValue;
    data['tagDataId'] = this.tagDataId;
    data['tagId'] = this.tagId;
    data['tagPropId'] = this.tagPropId;
    data['textValue'] = this.textValue;
    data['themeId'] = this.themeId;
    data['timeValue'] = this.timeValue;
    data['updateTime'] = this.updateTime;
    data['userId'] = this.userId;
    return data;
  }
}
