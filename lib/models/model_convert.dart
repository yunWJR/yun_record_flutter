//
// Created by yun on 2020/4/24.
//

import 'package:yun_base/model/yun_base_model.dart';
import 'package:yun_base/model/yun_model_convert.dart';
import 'package:yun_record/models/user_vo.dart';


class ModelConvert {
  static init() {
    YunModelConvertDefine.factory = (String type, Map<String, dynamic> json) {
      return convert(type, json);
    };
  }

  static T convert<T extends YunBaseModel>(String type, Map<String, dynamic> json) {
    switch (type) {
      case 'UserVo':
        return UserVo.fromJson(json) as T;
    }

    return null;
  }
}
