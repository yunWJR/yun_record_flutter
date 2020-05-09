import 'package:yun_base/model/yun_base_model.dart';
import 'package:yun_record/models/theme_vo.dart';

import '../index.dart';

class PlanVo extends YunBaseModel {
  String content;
  int createTime; // 0
  int id; // 0
  int status; // 0
  int tagId; // 0
  int updateTime; // 0
  int userId; // 0
  int themeId; // 0
  ThemeVo theme;

  bool isCmp() {
    return status != null && status > 0;
  }

  TextEditingController nameController;
  TextFormField nameTf;

  PlanVo(
      {this.content,
      this.createTime,
      this.id,
      this.status,
      this.tagId,
      this.themeId,
      this.theme,
      this.updateTime,
      this.userId});

  factory PlanVo.fromJson(Map<String, dynamic> json) {
    return PlanVo(
      content: json['content'],
      createTime: json['createTime'],
      id: json['id'],
      status: json['status'],
      tagId: json['tagId'],
      themeId: json['themeId'],
      theme: json['theme'] != null ? ThemeVo.fromJson(json['theme']) : null,
      updateTime: json['updateTime'],
      userId: json['userId'],
    );
  }

  fromJson(Map<String, dynamic> json) {
    return PlanVo(
      content: json['content'],
      createTime: json['createTime'],
      id: json['id'],
      status: json['status'],
      tagId: json['tagId'],
      themeId: json['themeId'],
      theme: json['theme'] != null ? ThemeVo.fromJson(json['theme']) : null,
      updateTime: json['updateTime'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['status'] = this.status;
    data['tagId'] = this.tagId;
    data['themeId'] = this.themeId;
    data['updateTime'] = this.updateTime;
    data['userId'] = this.userId;
    if (this.theme != null) {
      data['theme'] = this.theme.toJson();
    }

    return data;
  }

  factory PlanVo.dto() {
    PlanVo dto = PlanVo();
    dto.status = 0;

    dto.nameController = TextEditingController();
    dto.nameTf = new TextFormField(
        autofocus: true,
        controller: dto.nameController,
        validator: (String value) {
          return YunValue.isNullOrEmpty(value) ? "请输入待办内容" : null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "待办*",
          hintText: "请输入待办内容",
        ));

    return dto;
  }

  String checkAndReform() {
    this.content = nameController.text;
    if (YunValue.hasContent(content)) {
      return null;
    }

    return "请填写待办内容";
  }
}
