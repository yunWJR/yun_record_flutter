package other

class Theme {
    int createTime; // 1578493271034
    int id; // 1
    String name; // 小包子
    String remark; // 我的乖儿子
    int updateTime; // 1578493271034
    int userId; // 1

    Theme({this.createTime, this.id, this.name, this.remark, this.updateTime, this.userId});

    factory Theme.fromJson(Map<String, dynamic> json) {
        return Theme(
            createTime: json['createTime'], 
            id: json['id'], 
            name: json['name'], 
            remark: json['remark'], 
            updateTime: json['updateTime'], 
            userId: json['userId'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['createTime'] = this.createTime;
        data['id'] = this.id;
        data['name'] = this.name;
        data['remark'] = this.remark;
        data['updateTime'] = this.updateTime;
        data['userId'] = this.userId;
        return data;
    }
}