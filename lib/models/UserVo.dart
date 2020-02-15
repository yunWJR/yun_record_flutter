import '../common/model/BaseModel.dart';

class UserVo implements BaseModel {
  String acctName;
  int createTime; // 0
  String email;
  int enabled; // 0
  String headerUrl;
  int id; // 0
  String loginToken;
  String name;
  String phone;
  String weChat;

  UserVo(
      {this.acctName,
      this.createTime,
      this.email,
      this.enabled,
      this.headerUrl,
      this.id,
      this.loginToken,
      this.name,
      this.phone,
      this.weChat});

  factory UserVo.fromJson(Map<String, dynamic> json) {
    return UserVo(
      acctName: json['acctName'],
      createTime: json['createTime'],
      email: json['email'],
      enabled: json['enabled'],
      headerUrl: json['headerUrl'],
      id: json['id'],
      loginToken: json['loginToken'],
      name: json['name'],
      phone: json['phone'],
      weChat: json['weChat'],
    );
  }

  fromJson(Map<String, dynamic> json) {
    if (json['acctName'] != null) {
      this.acctName = json['acctName']?.toString();
    }
    if (json['createTime'] != null) {
      this.createTime = json['createTime']?.toInt();
    }
    if (json['email'] != null) {
      this.email = json['email']?.toString();
    }
    if (json['enabled'] != null) {
      this.enabled = json['enabled']?.toInt();
    }
    if (json['headerUrl'] != null) {
      this.headerUrl = json['headerUrl']?.toString();
    }
    if (json['id'] != null) {
      this.id = json['id']?.toInt();
    }
    if (json['loginToken'] != null) {
      this.loginToken = json['loginToken']?.toString();
    }
    if (json['name'] != null) {
      this.name = json['name']?.toString();
    }
    if (json['phone'] != null) {
      this.phone = json['phone']?.toString();
    }
    if (json['weChat'] != null) {
      this.weChat = json['weChat']?.toString();
    }

    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acctName'] = this.acctName;
    data['createTime'] = this.createTime;
    data['email'] = this.email;
    data['enabled'] = this.enabled;
    data['headerUrl'] = this.headerUrl;
    data['id'] = this.id;
    data['loginToken'] = this.loginToken;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['weChat'] = this.weChat;

    return data;
  }
}
