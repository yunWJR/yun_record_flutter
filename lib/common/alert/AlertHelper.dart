import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertHelper {
  static   void showErr(BuildContext context) {
    // hide loading

    showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
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
