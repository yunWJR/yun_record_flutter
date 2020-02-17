package other

class PropDataX {
    Object bigDecimalValue; // null
    int createTime; // 1578988218186
    int creatorId; // 1
    int dataType; // 2
    Object dataTypeId; // null
    Object doubleValue; // null
    Object enumValue; // null
    int id; // 178
    int intValue; // 1
    String orgValue; // 1
    int tagDataId; // 198
    int tagId; // 5
    int tagPropId; // 2
    Object textValue; // null
    int themeId; // 1
    Object timeValue; // null
    int updateTime; // 1578988218186
    int userId; // 1

    PropDataX({this.bigDecimalValue, this.createTime, this.creatorId, this.dataType, this.dataTypeId, this.doubleValue, this.enumValue, this.id, this.intValue, this.orgValue, this.tagDataId, this.tagId, this.tagPropId, this.textValue, this.themeId, this.timeValue, this.updateTime, this.userId});

    factory PropDataX.fromJson(Map<String, dynamic> json) {
        return PropDataX(
            bigDecimalValue: json['bigDecimalValue'] != null ? Object.fromJson(json['bigDecimalValue']) : null, 
            createTime: json['createTime'], 
            creatorId: json['creatorId'], 
            dataType: json['dataType'], 
            dataTypeId: json['dataTypeId'] != null ? Object.fromJson(json['dataTypeId']) : null, 
            doubleValue: json['doubleValue'] != null ? Object.fromJson(json['doubleValue']) : null, 
            enumValue: json['enumValue'] != null ? Object.fromJson(json['enumValue']) : null, 
            id: json['id'], 
            intValue: json['intValue'], 
            orgValue: json['orgValue'], 
            tagDataId: json['tagDataId'], 
            tagId: json['tagId'], 
            tagPropId: json['tagPropId'], 
            textValue: json['textValue'] != null ? Object.fromJson(json['textValue']) : null, 
            themeId: json['themeId'], 
            timeValue: json['timeValue'] != null ? Object.fromJson(json['timeValue']) : null, 
            updateTime: json['updateTime'], 
            userId: json['userId'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['createTime'] = this.createTime;
        data['creatorId'] = this.creatorId;
        data['dataType'] = this.dataType;
        data['id'] = this.id;
        data['intValue'] = this.intValue;
        data['orgValue'] = this.orgValue;
        data['tagDataId'] = this.tagDataId;
        data['tagId'] = this.tagId;
        data['tagPropId'] = this.tagPropId;
        data['themeId'] = this.themeId;
        data['updateTime'] = this.updateTime;
        data['userId'] = this.userId;
        if (this.bigDecimalValue != null) {
            data['bigDecimalValue'] = this.bigDecimalValue.toJson();
        }
        if (this.dataTypeId != null) {
            data['dataTypeId'] = this.dataTypeId.toJson();
        }
        if (this.doubleValue != null) {
            data['doubleValue'] = this.doubleValue.toJson();
        }
        if (this.enumValue != null) {
            data['enumValue'] = this.enumValue.toJson();
        }
        if (this.textValue != null) {
            data['textValue'] = this.textValue.toJson();
        }
        if (this.timeValue != null) {
            data['timeValue'] = this.timeValue.toJson();
        }
        return data;
    }
}