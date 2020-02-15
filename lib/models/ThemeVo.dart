import 'package:yun_record/common/model/BaseModel.dart';

import 'Tag.dart';

class ThemeVo implements BaseModel {
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
