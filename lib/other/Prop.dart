package other

class Prop {
    int createTime; // 1578495265771
    int dataType; // 2
    Object dataTypeId; // null
    String dataUnit; // ml
    int id; // 2
    String name; // 容量
    int tagId; // 5
    int themeId; // 1
    int updateTime; // 1578495265771
    int userId; // 1

    Prop({this.createTime, this.dataType, this.dataTypeId, this.dataUnit, this.id, this.name, this.tagId, this.themeId, this.updateTime, this.userId});

    factory Prop.fromJson(Map<String, dynamic> json) {
        return Prop(
            createTime: json['createTime'], 
            dataType: json['dataType'], 
            dataTypeId: json['dataTypeId'] != null ? Object.fromJson(json['dataTypeId']) : null, 
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
        if (this.dataTypeId != null) {
            data['dataTypeId'] = this.dataTypeId.toJson();
        }
        return data;
    }
}