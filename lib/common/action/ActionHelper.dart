import 'package:flutter/cupertino.dart';

class ActionHelper {
  static Future<int> showIOSAction(
    BuildContext context,
    List<String> actions, {
    String title,
    String message,
  }) async {
    int i = await showCupertinoModalPopup<int>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: title == null ? null : Text(title ?? "选择"),
            message: message == null ? null : Text(message ?? "选择"),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: new Text("取消"),
            ),
            actions: actions.asMap().keys.map((index) {
              return CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context, index);
                },
                child: new Text(actions[index]),
              );
            }).toList(),
          );
        });

    return i;
  }
}
