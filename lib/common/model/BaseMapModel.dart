import 'BaseModel.dart';

class BaseMapModel implements BaseModel {
  Map<String, dynamic> json;

  BaseMapModel({this.json});

  BaseMapModel fromJson(Map<String, dynamic> json) {
    return BaseMapModel(
      json: json,
    );
  }

  Map<String, dynamic> toJson() {
    return json;
  }
}
