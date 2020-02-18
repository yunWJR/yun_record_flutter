import 'package:yun_record/common/model/YunBaseModel.dart';

import 'Prop.dart';

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
