import 'package:flutter/material.dart';
import 'package:yun_record/common/git_api.dart';
import 'package:yun_record/common/model/PageBaseNotiModel.dart';

import 'UserVo.dart';

/// Storages essencial data from the next scheduled UserVo.
/// Used in the 'Home' tab, under the SpaceX screen.
class HomeModel extends PageBaseNotiModel {
  HomeModel(BuildContext context) : super(context);

  @override
  Future loadData([BuildContext context]) async {
    if (await canLoadData()) {
      // Add parsed item

      await Future.delayed(Duration(milliseconds: 1000));

//      UserVo user = await Git(context).login("y", "y");
//      items.add(user);
//      print('loadData cmp');

      // Adds notifications to queue
//      await initNotifications(context);

      // Add photos & shuffle them
//      if (photos.isEmpty) {
//        photos.addAll(SpaceXPhotos.home);
//        photos.shuffle();
//      }
      finishLoading();
    }
  }

  UserVo get userVo => (items != null && items.length > 0) ? items[0] : null;
}
