import 'package:yun_base/model/yun_base_model.dart';

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
}
