import 'dart:async';

import 'package:yun_base/http/yun_http.dart';
import 'package:yun_base/model/yun_base_map_model.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/model/yun_rst_data.dart';

class RecordApi {
  static Future<YunBaseMapModel> saveRecordData<N extends YunPageBaseNotiModel>(N model, data) async {
    YunRspData<YunBaseMapModel> rst =
        await YunHttp(model).post(YunBaseMapModel(), "/v1/api/record/tagData", data, null);

    return rst?.data;
  }

  static Future<YunBaseMapModel> saveRecord<N extends YunPageBaseNotiModel>(N model, data) async {
    YunRspData<YunBaseMapModel> rst = await YunHttp(model).post(YunBaseMapModel(), "/v1/api/record/tag", data, null);

    return rst?.data;
  }
}
