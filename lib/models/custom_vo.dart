import 'package:yun_base/model/yun_base_model.dart';
import 'package:yun_record/widgets/select_theme.dart';

import '../index.dart';

class CustomDefine {
  static String typeName(int type) {
    if (type == null) {
      return "无";
    }

    if (type == 1) {
      return "每日";
    }

    if (type == 2) {
      return "每周";
    }

    return "未知";
  }
}

class Custom extends YunBaseModel {
  String completePara;
  int completeType; // 0
  int createTime; // 0
  int enable; // 0
  int id; // 0
  String name;
  int tagId; // 0
  int themeId; // 0
  int type; // 0
  String typePara;
  int updateTime; // 0
  int userId; // 0

  GlobalKey<SelectThemeState> themeKey = new GlobalKey<SelectThemeState>();

  GlobalKey<FormState> nameFormKey = new GlobalKey<FormState>();
  GlobalKey<FormState> completeParaFormKey = new GlobalKey<FormState>();
  bool autoValidate = false;

  TextEditingController nameController;
  TextFormField nameTf;

  TextEditingController completeParaController;
  TextFormField completeParaTf;

  Custom(
      {this.completePara,
      this.completeType,
      this.createTime,
      this.enable,
      this.id,
      this.name,
      this.tagId,
      this.themeId,
      this.type,
      this.typePara,
      this.updateTime,
      this.userId});

  factory Custom.fromJson(Map<String, dynamic> json) {
    return Custom(
      completePara: json['completePara'],
      completeType: json['completeType'],
      createTime: json['createTime'],
      enable: json['enable'],
      id: json['id'],
      name: json['name'],
      tagId: json['tagId'],
      themeId: json['themeId'],
      type: json['type'],
      typePara: json['typePara'],
      updateTime: json['updateTime'],
      userId: json['userId'],
    );
  }

  fromJson(Map<String, dynamic> json) {
    return Custom(
      completePara: json['completePara'],
      completeType: json['completeType'],
      createTime: json['createTime'],
      enable: json['enable'],
      id: json['id'],
      name: json['name'],
      tagId: json['tagId'],
      themeId: json['themeId'],
      type: json['type'],
      typePara: json['typePara'],
      updateTime: json['updateTime'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completePara'] = this.completePara;
    data['completeType'] = this.completeType;
    data['createTime'] = this.createTime;
    data['enable'] = this.enable;
    data['id'] = this.id;
    data['name'] = this.name;
    data['tagId'] = this.tagId;
    data['themeId'] = this.themeId;
    data['type'] = this.type;
    data['typePara'] = this.typePara;
    data['updateTime'] = this.updateTime;
    data['userId'] = this.userId;
    return data;
  }

  static Custom dto() {
    Custom dto = Custom();
    dto.enable = 1;
    dto.type = 1;
    dto.completeType = 1;

    dto.nameController = TextEditingController();
    dto.nameTf = new TextFormField(
        autofocus: true,
        controller: dto.nameController,
        validator: (String value) {
          return YunValue.isNullOrEmpty(value) ? "请输入习惯名称" : null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "习惯名称*",
          hintText: "请输入习惯名称",
        ));

    dto.completeParaController = TextEditingController();
    dto.completeParaTf = new TextFormField(
        controller: dto.completeParaController,
        validator: (String value) {
          return YunValue.isNullOrEmpty(value) ? "请输入完成量" : null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "完成量*",
          hintText: "请输入完成量",
        ));

    return dto;
  }

  String checkAndReform() {
    this.name = nameController.text;
    this.completePara = completeParaController.text;

    // todo

    return null;
  }
}
