import 'BaseModel.dart';

class RstData<T extends BaseModel> {
  int code;
  T data;
  String errorMsg;

  RstData(this.code, this.data, this.errorMsg);

  factory RstData.fromJson(T d, Map<String, dynamic> map) {
    return RstData<T>(
      map['code'],
      d.fromJson(map['data']),
      map['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['errorMsg'] = this.errorMsg;
    data['data'] = this.data.toJson();

    return data;
  }
}
