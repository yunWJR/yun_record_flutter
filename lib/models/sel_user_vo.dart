import 'package:yun_base/model/yun_base_model.dart';

class SelUserVo implements YunBaseModel {
  String email;
  int enabled; // 0
  String headerUrl;
  int id; // 0
  String name;
  String phone;
  String weChat;

  bool selected = false;

  SelUserVo({this.email, this.enabled, this.headerUrl, this.id, this.name, this.phone, this.weChat});

  factory SelUserVo.fromJson(Map<String, dynamic> json) {
    return SelUserVo(
      email: json['email'],
      enabled: json['enabled'],
      headerUrl: json['headerUrl'],
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      weChat: json['weChat'],
    );
  }

  fromJson(Map<String, dynamic> json) {
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
    data['email'] = this.email;
    data['enabled'] = this.enabled;
    data['headerUrl'] = this.headerUrl;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['weChat'] = this.weChat;

    return data;
  }
}
