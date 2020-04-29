//
// Created by yun on 2020/4/24.
//

import 'package:yun_base/model/yun_base_model.dart';
import 'package:yun_base/model/yun_model_convert.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/models/user_vo.dart';

import 'TagDataVo.dart';

class ModelConvert {
  static init() {
    YunModelConvertDefine.factory = (String type, Map<String, dynamic> json) {
      return convert(type, json);
    };
  }

  static T convert<T extends YunBaseModel>(String type, Map<String, dynamic> json) {
    switch (type) {
      //      case 'YunBaseMapModel':
//        return YunBaseMapModel.fromJson(json) as T;
      case 'UserVo':
        return UserVo.fromJson(json) as T;
      case 'ThemeVoNew':
        return ThemeVo.fromJson(json) as T;
      case 'TagDataVo':
        return TagDataVo.fromJson(json) as T;
    }

    return null;
  }
}
