import 'package:flutter/material.dart';
import 'package:yun_record/common/git_api.dart';
import 'package:yun_record/common/model/query_model.dart';

import 'UserVo.dart';

/// Storages essencial data from the next scheduled UserVo.
/// Used in the 'Home' tab, under the SpaceX screen.
class HomeModel extends QueryModel {
  HomeModel(BuildContext context) : super(context);

  @override
  Future loadData([BuildContext context]) async {
    print('loadDataloadDataloadDataloadDataloadDataloadDataloadData');

    if (await canLoadData()) {
      // Add parsed item

      await Future.delayed(Duration(milliseconds: 4000));

      UserVo user = await Git(context).login("y", "y");



      items.add(user);

      print('loadData cmp');

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
}
