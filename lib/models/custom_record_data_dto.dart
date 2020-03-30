import 'package:yun_base/model/yun_base_model.dart';
import 'package:yun_record/models/custom_data_vo.dart';

class CustomRecordDataDto extends YunBaseModel {
  int dataType; // 0
  String dataValue;
  int id; // 0
  int recordId; // 0
  int userTime; // 0

  CustomRecordDataDto({this.dataType, this.dataValue, this.id, this.recordId, this.userTime});

  factory CustomRecordDataDto.fromJson(Map<String, dynamic> json) {
    return CustomRecordDataDto(
      dataType: json['dataType'],
      dataValue: json['dataValue'],
      id: json['id'],
      recordId: json['recordId'],
      userTime: json['userTime'],
    );
  }

  fromJson(Map<String, dynamic> json) {
    return CustomRecordDataDto(
      dataType: json['dataType'],
      dataValue: json['dataValue'],
      id: json['id'],
      recordId: json['recordId'],
      userTime: json['userTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataType'] = this.dataType;
    data['dataValue'] = this.dataValue;
    data['id'] = this.id;
    data['recordId'] = this.recordId;
    data['userTime'] = this.userTime;
    return data;
  }

  static CustomRecordDataDto newItem(CustomDataVo item) {
    CustomRecordDataDto dto = CustomRecordDataDto();
    dto.recordId = item.id;
    dto.dataType = item.dataType;
    dto.userTime = DateTime.now().millisecondsSinceEpoch;

    return dto;
  }
}
