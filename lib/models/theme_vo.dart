import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yun_base/model/yun_base_model.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/TagVo.dart';

typedef ValidErr = Function(String errMsg);

class ThemeVo extends YunBaseModel {
  int businessId; // 0
  int businessType; // 0
  int createTime; // 0
  int id; // 0
  String name;
  int parentId; // 0
  String remark;
  int themeShareType; // 0
  int userId; // 0
  List<ThemeVo> childList;
  List<TagVo> tagList;

  bool isExpand = false;

  ThemeVo(
      {this.businessId,
      this.businessType,
      this.childList,
      this.tagList,
      this.createTime,
      this.id,
      this.name,
      this.parentId,
      this.remark,
      this.themeShareType,
      this.userId});

  factory ThemeVo.fromJson(Map<String, dynamic> json) {
    return ThemeVo(
      businessId: json['businessId'],
      businessType: json['businessType'],
      childList:
          json['childList'] != null ? (json['childList'] as List).map((i) => ThemeVo.fromJson(i)).toList() : null,
      tagList: json['tagList'] != null ? (json['tagList'] as List).map((i) => TagVo.fromJson(i)).toList() : null,
      createTime: json['createTime'],
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      remark: json['remark'],
      themeShareType: json['themeShareType'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessId'] = this.businessId;
    data['businessType'] = this.businessType;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    data['remark'] = this.remark;
    data['themeShareType'] = this.themeShareType;
    data['userId'] = this.userId;
    if (this.childList != null) {
      data['childList'] = this.childList.map((v) => v.toJson()).toList();
    }
    if (this.tagList != null) {
      data['tagList'] = this.tagList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // dto
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  final TextEditingController nameController = new TextEditingController();
  TextFormField nameTf;

  factory ThemeVo.dto() {
    ThemeVo dto = ThemeVo();

    // 默认 type
    dto.businessType = 2;

    dto.nameTf = new TextFormField(
        autofocus: true,
        controller: dto.nameController,
        validator: (String value) {
          return YunValue.isNullOrEmpty(value) ? "请输入主题名称" : null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "主题名称*",
          hintText: "请输入主题名称",
        ));

    return dto;
  }

  bool valid(ValidErr validErr) {
    if (!formKey.currentState.validate()) {
      return false;
    }

//    if (tagList == null || tagList.length == 0) {
//      validErr("至少添加一个记录项");
//      return false;
//    }

//    for (var value in tagList) {
//      if (!value.valid(validErr)) {
//        return false;
//      }
//    }

    return true;
  }

  void getData() {
    this.name = nameController.text;

//    for (var value in tagList) {
//      value.getData();
//    }
  }
}

//class ThemeVoNew implements YunBaseModel {
//  int createTime; // 0
//  int id; // 0
//  String name;
//  String remark;
//  List<Tag> tagList;
//
//  bool isExpand = false;
//
//  ThemeVoNew({this.createTime, this.id, this.name, this.remark, this.tagList});
//
//  ThemeVoNew fromJson(Map<String, dynamic> json) {
//    ThemeVoNew vo = ThemeVoNew(
//      createTime: json['createTime'],
//      id: json['id'],
//      name: json['name'],
//      remark: json['remark'],
//      tagList: json['tagList'] != null ? (json['tagList'] as List).map((i) => Tag().fromJson(i)).toList() : null,
//    );
//
//    return vo;
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['createTime'] = this.createTime;
//    data['id'] = this.id;
//    data['name'] = this.name;
//    data['remark'] = this.remark;
//    if (this.tagList != null) {
//      data['tagList'] = this.tagList.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//
//  // dto
//  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
//
//  final TextEditingController nameController = new TextEditingController();
//  TextFormField nameTf;
//
//  factory ThemeVoNew.dto() {
//    ThemeVoNew dto = ThemeVoNew();
//
//    dto.nameTf = new TextFormField(
//        autofocus: true,
//        controller: dto.nameController,
//        validator: (String value) {
//          return YunValue.isNullOrEmpty(value) ? "请输入主题名称" : null;
//        },
//        keyboardType: TextInputType.text,
//        decoration: InputDecoration(
//          labelText: "主题名称*",
//          hintText: "请输入主题名称",
//        ));
//
//    dto.tagList = [];
//    dto.tagList.add(Tag.dto());
//
//    return dto;
//  }
//
//  bool valid(ValidErr validErr) {
//    if (!formKey.currentState.validate()) {
//      return false;
//    }
//
//    if (tagList == null || tagList.length == 0) {
//      validErr("至少添加一个记录项");
//      return false;
//    }
//
//    for (var value in tagList) {
//      if (!value.valid(validErr)) {
//        return false;
//      }
//    }
//
//    return true;
//  }
//
//  void getData() {
//    this.name = nameController.text;
//
//    for (var value in tagList) {
//      value.getData();
//    }
//  }
//}
//
//class Tag implements YunBaseModel {
//  int createTime; // 0
//  int id; // 0
//  int themeId; // 0
//  String name;
//  List<Prop> propList;
//  String remark;
//
//  Tag({this.createTime, this.id, this.themeId, this.name, this.propList, this.remark});
//
//  // dto
//  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
//
//  final TextEditingController nameController = new TextEditingController();
//  TextFormField nameTf;
//
//  factory Tag.dto() {
//    Tag dtoTag = Tag();
//
//    dtoTag.nameTf = new TextFormField(
//        controller: dtoTag.nameController,
//        validator: (String value) {
//          return YunValue.isNullOrEmpty(value) ? "请输入记录项名称" : null;
//        },
//        keyboardType: TextInputType.text,
//        decoration: InputDecoration(
//          labelText: "记录项名称*",
//          hintText: "请输入记录项名称",
//        ));
//
//    dtoTag.propList = [];
////    dtoTag.propList.add(Prop.dto());
//
//    return dtoTag;
//  }
//
//  Tag fromJson(Map<String, dynamic> json) {
//    return Tag(
//      createTime: json['createTime'],
//      id: json['id'],
//      themeId: json['themeId'],
//      name: json['name'],
//      propList: json['propList'] != null ? (json['propList'] as List).map((i) => Prop().fromJson(i)).toList() : null,
//      remark: json['remark'],
//    );
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['createTime'] = this.createTime;
//    data['id'] = this.id;
//    data['themeId'] = this.themeId;
//    data['name'] = this.name;
//    data['remark'] = this.remark;
//    if (this.propList != null) {
//      data['propList'] = this.propList.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//
//  bool valid(ValidErr validErr) {
//    if (!formKey.currentState.validate()) {
//      return false;
//    }
//
//    if (propList == null || propList.length == 0) {
////      validErr("记录项${name}至少添加一个属性");
//      return true;
//    }
//
//    for (var value in propList) {
//      if (!value.valid(validErr)) {
//        return false;
//      }
//    }
//
//    return true;
//  }
//
//  void getData() {
//    this.name = nameController.text;
//
//    for (var value in propList) {
//      value.getData();
//    }
//  }
//}
//
//class Prop implements YunBaseModel {
//  int id; // 0
//  int tagId; // 0
//  int createTime; // 0
//  int dataType; // 0
//  int dataTypeId; // 0
//  String dataUnit;
//  String name;
//
//  Prop({this.id, this.tagId, this.createTime, this.dataType, this.dataTypeId, this.dataUnit, this.name});
//
//  // dto
//  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
//
//  final TextEditingController nameController = new TextEditingController();
//  TextFormField nameTf;
//
//  final TextEditingController dataTypeController = new TextEditingController();
//  TextFormField dataTypeTf;
//
//  GlobalKey<DataTypePopupMenuState> dataTypeKey = new GlobalKey<DataTypePopupMenuState>();
//  DataTypePopupMenu dataTypePopupMenu;
//
//  final TextEditingController dataUnitController = new TextEditingController();
//  TextFormField dataUnitTf;
//
//  factory Prop.dto() {
//    Prop propDtp = Prop();
//
//    propDtp.dataTypePopupMenu = DataTypePopupMenu(
//      key: propDtp.dataTypeKey,
//      typeChanged: (int type) {
//        propDtp.dataType = type;
////        propDtp.dataTypeKey.currentState.onChanged(type);
//      },
//    );
//
//    propDtp.nameTf = new TextFormField(
//        controller: propDtp.nameController,
//        validator: (String value) {
//          return YunValue.isNullOrEmpty(value) ? "请输入条目名称" : null;
//        },
//        keyboardType: TextInputType.text,
//        decoration: InputDecoration(
//          labelText: "条目名称*",
//          hintText: "请输入条目名称",
//        ));
//
//    propDtp.dataTypeTf = new TextFormField(
//        controller: propDtp.dataTypeController,
//        validator: (String value) {
//          return YunValue.isNullOrEmpty(value) ? "请选择类型" : null;
//        },
//        keyboardType: TextInputType.text,
//        decoration: InputDecoration(
//          labelText: "类型*",
//          hintText: "请选择类型",
//        ));
//
//    propDtp.dataUnitTf = new TextFormField(
//        controller: propDtp.dataUnitController,
//        validator: (String value) {
//          return null;
//        },
//        keyboardType: TextInputType.text,
//        decoration: InputDecoration(
//          labelText: "单位",
//          hintText: "请输入单位",
//        ));
//
//    return propDtp;
//  }
//
//  Prop fromJson(Map<String, dynamic> json) {
//    return Prop(
//      id: json['id'],
//      tagId: json['tagId'],
//      createTime: json['createTime'],
//      dataType: json['dataType'],
//      dataTypeId: json['dataTypeId'],
//      dataUnit: json['dataUnit'],
//      name: json['name'],
//    );
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['tagId'] = this.tagId;
//    data['createTime'] = this.createTime;
//    data['dataType'] = this.dataType;
//    data['dataTypeId'] = this.dataTypeId;
//    data['dataUnit'] = this.dataUnit;
//    data['name'] = this.name;
//    return data;
//  }
//
//  String dataUnitName() {
//    return YunValue.hasContent(dataUnit) ? dataUnit : "无";
//  }
//
//  bool valid(ValidErr validErr) {
//    if (formKey == null || formKey.currentState == null) {
//      return true;
//    }
//
//    if (!formKey.currentState.validate()) {
//      return false;
//    }
//
//    if (dataType == null) {
//      validErr("请选择数据类型");
//      return false;
//    }
//
//    return true;
//  }
//
//  void getData() {
//    this.name = nameController.text;
//    this.dataType = dataTypePopupMenu.typeValue; // todo
//    this.dataUnit = dataUnitController.text;
//  }
//}
