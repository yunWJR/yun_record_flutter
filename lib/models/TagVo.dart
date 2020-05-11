import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/widgets/data_type_popup_menu.dart';
import 'package:yun_record/widgets/select_theme.dart';

import 'ThemeVoBack.dart';

class TagVo {
  int createTime; // 0
  int id; // 0
  String name;
  List<TagPropVo> propList;
  String remark;
  int themeId; // 0

  TagVo({this.createTime, this.id, this.name, this.propList, this.remark, this.themeId});

  factory TagVo.fromJson(Map<String, dynamic> json) {
    return TagVo(
      createTime: json['createTime'],
      id: json['id'],
      name: json['name'],
      propList: json['propList'] != null ? (json['propList'] as List).map((i) => TagPropVo.fromJson(i)).toList() : null,
      remark: json['remark'],
      themeId: json['themeId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['themeId'] = this.themeId;
    if (this.propList != null) {
      data['propList'] = this.propList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // dto
  GlobalKey<SelectThemeState> themeKey = new GlobalKey<SelectThemeState>();

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  final TextEditingController nameController = new TextEditingController();
  TextFormField nameTf;

  factory TagVo.dto() {
    TagVo dtoTag = TagVo();

    dtoTag.nameTf = new TextFormField(
        controller: dtoTag.nameController,
        validator: (String value) {
          return YunValue.isNullOrEmpty(value) ? "请输入记录项名称" : null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "记录项名称*",
          hintText: "请输入记录项名称",
        ));

    dtoTag.propList = [];
    dtoTag.propList.add(TagPropVo.dto());

    return dtoTag;
  }

  bool valid(ValidErr validErr) {
    if (!formKey.currentState.validate()) {
      return false;
    }

    if (propList == null || propList.length == 0) {
//      validErr("记录项${name}至少添加一个属性");
      return true;
    }

    for (var value in propList) {
      if (!value.valid(validErr)) {
        return false;
      }
    }

    return true;
  }

  void getData() {
    this.name = nameController.text;

    for (var value in propList) {
      value.getData();
    }
  }
}

class TagPropVo {
  int createTime; // 0
  int dataType; // 0
  int dataTypeId; // 0
  String dataUnit;
  int id; // 0
  String name;
  int tagId; // 0

  TagPropVo({this.createTime, this.dataType, this.dataTypeId, this.dataUnit, this.id, this.name, this.tagId});

  factory TagPropVo.fromJson(Map<String, dynamic> json) {
    return TagPropVo(
      createTime: json['createTime'],
      dataType: json['dataType'],
      dataTypeId: json['dataTypeId'],
      dataUnit: json['dataUnit'],
      id: json['id'],
      name: json['name'],
      tagId: json['tagId'],
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
    data['tagId'] = this.tagId;
    return data;
  }

  // dto
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  final TextEditingController nameController = new TextEditingController();
  TextFormField nameTf;

  final TextEditingController dataTypeController = new TextEditingController();
  TextFormField dataTypeTf;

  GlobalKey<DataTypePopupMenuState> dataTypeKey = new GlobalKey<DataTypePopupMenuState>();
  DataTypePopupMenu dataTypePopupMenu;

  final TextEditingController dataUnitController = new TextEditingController();
  TextFormField dataUnitTf;

  factory TagPropVo.dto() {
    TagPropVo propDtp = TagPropVo();

    propDtp.dataTypePopupMenu = DataTypePopupMenu(
      key: propDtp.dataTypeKey,
      typeChanged: (int type) {
        propDtp.dataType = type;
//        propDtp.dataTypeKey.currentState.onChanged(type);
      },
    );

    propDtp.nameTf = new TextFormField(
        controller: propDtp.nameController,
        validator: (String value) {
          return YunValue.isNullOrEmpty(value) ? "请输入条目名称" : null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "条目名称*",
          hintText: "请输入条目名称",
        ));

    propDtp.dataTypeTf = new TextFormField(
        controller: propDtp.dataTypeController,
        validator: (String value) {
          return YunValue.isNullOrEmpty(value) ? "请选择类型" : null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "类型*",
          hintText: "请选择类型",
        ));

    propDtp.dataUnitTf = new TextFormField(
        controller: propDtp.dataUnitController,
        validator: (String value) {
          return null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "单位",
          hintText: "请输入单位",
        ));

    return propDtp;
  }

  String dataUnitName() {
    return YunValue.hasContent(dataUnit) ? dataUnit : "无";
  }

  bool valid(ValidErr validErr) {
    if (formKey == null || formKey.currentState == null) {
      return true;
    }

    if (!formKey.currentState.validate()) {
      return false;
    }

    if (dataType == null) {
      validErr("请选择数据类型");
      return false;
    }

    return true;
  }

  void getData() {
    this.name = nameController.text;
    this.dataType = dataTypePopupMenu.typeValue; // todo
    this.dataUnit = dataUnitController.text;
  }
}
