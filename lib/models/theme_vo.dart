import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yun_base/model/yun_base_model.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/TagVo.dart';

import 'ThemeShareItemVo.dart';

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

  List<ThemeShareItemVo> shareList;

  bool isExpand = false;

  ThemeVo(
      {this.businessId,
      this.businessType,
      this.childList,
      this.tagList,
      this.shareList,
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
      shareList: json['shareList'] != null
          ? (json['shareList'] as List).map((i) => ThemeShareItemVo.fromJson(i)).toList()
          : null,
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
    if (this.shareList != null) {
      data['shareList'] = this.shareList.map((v) => v.toJson()).toList();
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

  String nameWithType() {
    if (name == null) {
      return "";
    }

    if (businessType == 1) {
      return "我的主题";
    }

    if (businessType == 2) {
      if (themeShareType == 0) {
        return name;
      } else {
        return name + "(分享主题)";
      }
    }
  }
}
