//
// Created by yun on 2020-02-16.
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yun_record/common/config/YunConfig.dart';
import 'package:yun_record/common/log/LogHelper.dart';

class AlertHelper {
  static void showErr(BuildContext context, String error) {
    if (YunConfig.iOSMode()) {
      return showIOSErr(context, error);
    } else {
      // todo 后期增加
      return showIOSErr(context, error);
    }
  }

  static void showIOSErr(BuildContext context, String error) {
    Log.log("ERROR", error);

    showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("提示"),
          content: Text(error),
          actions: <Widget>[
//            FlatButton(
//              child: Text("取消"),
//              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
//            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
