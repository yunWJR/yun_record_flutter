import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertHelper {
  static void showErr(BuildContext context, String error) {
    // hide loading

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

//    notifyListeners();
  }
}
