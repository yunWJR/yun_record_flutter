class Tag {
  int createTime; // 0
  int id; // 0
  String name;
  List<TagProp> propList;
  String remark;
  int themeId; // 0

  Tag({this.createTime, this.id, this.name, this.propList, this.remark, this.themeId});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      createTime: json['createTime'],
      id: json['id'],
      name: json['name'],
      propList: json['propList'] != null ? (json['propList'] as List).map((i) => TagProp.fromJson(i)).toList() : null,
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
}

class TagProp {
  int createTime; // 0
  int dataType; // 0
  int dataTypeId; // 0
  String dataUnit;
  int id; // 0
  String name;
  int tagId; // 0

  TagProp({this.createTime, this.dataType, this.dataTypeId, this.dataUnit, this.id, this.name, this.tagId});

  factory TagProp.fromJson(Map<String, dynamic> json) {
    return TagProp(
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
}
