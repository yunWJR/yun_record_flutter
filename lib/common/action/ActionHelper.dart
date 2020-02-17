import 'package:flutter/cupertino.dart';

class ActionHelper {
  static Future<int> showAction(BuildContext context, List<String> actions) async {
    int i = await showCupertinoModalPopup<int>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: const Text('请选择主题'),
//            message: const Text('请选择语言'),
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
