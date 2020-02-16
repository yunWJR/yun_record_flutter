import 'package:flutter/material.dart';
import 'package:yun_record/common/model/query_model.dart';

/// Storages essencial data from the next scheduled UserVo.
/// Used in the 'Home' tab, under the SpaceX screen.
class LoginModel extends QueryModel {
  LoginModel(BuildContext context) : super(context, initLoadData: false) {
//    initLoadData = false;
  }

  @override
  Future loadData([BuildContext context]) async {
    if (await canLoadData()) {
      // Add parsed item

      await Future.delayed(Duration(milliseconds: 1000));

      finishLoading();
    }
  }

  Future login([BuildContext context]) async {
    if (await canLoadData()) {
      // Add parsed item

      await Future.delayed(Duration(milliseconds: 1000));

      finishLoading();
    }
  }
}
