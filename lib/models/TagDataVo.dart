import 'package:yun_base/model/yun_base_model.dart';
import 'package:yun_record/models/theme_vo.dart';

class TagDataVo extends YunBaseModel {
  int createTime; // 1588170310432
  int creatorId; // 33
  String date; // 2020-04-29
  int dateTime; // 1588170279000
  int id; // 5
  String name; // 吃奶
  List<PropDataVoNew> propDataList;
  String remark;
  int tagId; // 5
  ThemeVo theme;
  int themeId; // 4
  String time; // 22:24:39
  int updateTime; // 1588170310432
  int userId; // 33

  TagDataVo(
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

  factory TagDataVo.fromJson(Map<String, dynamic> json) {
    return TagDataVo(
      createTime: json['createTime'],
      creatorId: json['creatorId'],
      date: json['date'],
      dateTime: json['dateTime'],
      id: json['id'],
      name: json['name'],
      propDataList: json['propDataList'] != null
          ? (json['propDataList'] as List).map((i) => PropDataVoNew.fromJson(i)).toList()
          : null,
      remark: json['remark'],
      tagId: json['tagId'],
      theme: json['theme'] != null ? ThemeVo.fromJson(json['theme']) : null,
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

class PropDataVoNew {
  bool hasData; // true
  PropVo prop;
  PropDataItemVo propData;

  PropDataVoNew({this.hasData, this.prop, this.propData});

  factory PropDataVoNew.fromJson(Map<String, dynamic> json) {
    return PropDataVoNew(
      hasData: json['hasData'],
      prop: json['prop'] != null ? PropVo.fromJson(json['prop']) : null,
      propData: json['propData'] != null ? PropDataItemVo.fromJsonMap(json['propData']) : null,
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

class PropVo {
  int createTime; // 1588170191495
  int dataType; // 1
  int dataTypeId; // 0
  String dataUnit; // ml
  int id; // 3
  String name; // 母乳
  int tagId; // 5
  int themeId; // 4
  int updateTime; // 1588170191495
  int userId; // 33

  PropVo(
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

  factory PropVo.fromJson(Map<String, dynamic> json) {
    return PropVo(
      createTime: json['createTime'],
      dataType: json['dataType'],
      dataTypeId: json['dataTypeId'] != null ? json['dataTypeId'] : null,
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

class PropDataItemVo {
  int bigDecimalValue;
  int createTime;
  int creatorId;
  int dataType;
  int dataTypeId;
  int doubleValue;
  int enumValue;
  int id;
  int intValue;
  String orgValue;
  int tagDataId;
  int tagId;
  int tagPropId;
  int taskStatus;
  String taskValue;
  String textValue;
  int themeId;
  String timeValue;
  int updateTime;
  int userId;

  PropDataItemVo.fromJsonMap(Map<String, dynamic> map)
      : bigDecimalValue = map["bigDecimalValue"],
        createTime = map["createTime"],
        creatorId = map["creatorId"],
        dataType = map["dataType"],
        dataTypeId = map["dataTypeId"],
        doubleValue = map["doubleValue"],
        enumValue = map["enumValue"],
        id = map["id"],
        intValue = map["intValue"],
        orgValue = map["orgValue"],
        tagDataId = map["tagDataId"],
        tagId = map["tagId"],
        tagPropId = map["tagPropId"],
        taskStatus = map["taskStatus"],
        taskValue = map["taskValue"],
        textValue = map["textValue"],
        themeId = map["themeId"],
        timeValue = map["timeValue"],
        updateTime = map["updateTime"],
        userId = map["userId"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bigDecimalValue'] = bigDecimalValue;
    data['createTime'] = createTime;
    data['creatorId'] = creatorId;
    data['dataType'] = dataType;
    data['dataTypeId'] = dataTypeId;
    data['doubleValue'] = doubleValue;
    data['enumValue'] = enumValue;
    data['id'] = id;
    data['intValue'] = intValue;
    data['orgValue'] = orgValue;
    data['tagDataId'] = tagDataId;
    data['tagId'] = tagId;
    data['tagPropId'] = tagPropId;
    data['taskStatus'] = taskStatus;
    data['taskValue'] = taskValue;
    data['textValue'] = textValue;
    data['themeId'] = themeId;
    data['timeValue'] = timeValue;
    data['updateTime'] = updateTime;
    data['userId'] = userId;
    return data;
  }
}
