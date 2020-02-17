package other

class Data {
    int createTime; // 1578988218026
    int creatorId; // 1
    String date; // 2020-01-14
    int dateTime; // 1578988215000
    int id; // 198
    String name; // 奶粉
    List<PropData> propDataList;
    String remark;
    int tagId; // 5
    Theme theme;
    int themeId; // 1
    String time; // 15:50:15
    int updateTime; // 1578988218026
    int userId; // 1

    Data({this.createTime, this.creatorId, this.date, this.dateTime, this.id, this.name, this.propDataList, this.remark, this.tagId, this.theme, this.themeId, this.time, this.updateTime, this.userId});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            createTime: json['createTime'], 
            creatorId: json['creatorId'], 
            date: json['date'], 
            dateTime: json['dateTime'], 
            id: json['id'], 
            name: json['name'], 
            propDataList: json['propDataList'] != null ? (json['propDataList'] as List).map((i) => PropData.fromJson(i)).toList() : null, 
            remark: json['remark'], 
            tagId: json['tagId'], 
            theme: json['theme'] != null ? Theme.fromJson(json['theme']) : null, 
            themeId: json['themeId'], 
            time: json['time'], 
            updateTime: json['updateTime'], 
            userId: json['userId'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['createTime'] = this.createTime;
        data['creatorId'] = this.creatorId;
        data['date'] = this.date;
        data['dateTime'] = this.dateTime;
        data['id'] = this.id;
        data['name'] = this.name;
        data['remark'] = this.remark;
        data['tagId'] = this.tagId;
        data['themeId'] = this.themeId;
        data['time'] = this.time;
        data['updateTime'] = this.updateTime;
        data['userId'] = this.userId;
        if (this.propDataList != null) {
            data['propDataList'] = this.propDataList.map((v) => v.toJson()).toList();
        }
        if (this.theme != null) {
            data['theme'] = this.theme.toJson();
        }
        return data;
    }
}