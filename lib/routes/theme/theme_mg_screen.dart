import 'package:flutter/material.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/config/global_config.dart';
import 'package:yun_record/routes/record/add_record_model.dart';

import '../../index.dart';

class ThemeMgScreen extends StatefulWidget {
  @override
  ThemeMgScreenState createState() => ThemeMgScreenState();
}

class ThemeMgScreenState extends State<ThemeMgScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddRecordModel>(
      builder: (context, model, child) => Scaffold(
        body: YunBasePage<AddRecordModel>.page(
          body: bodyWidget(model),
          model: model,
        ),
      ),
    );
  }

  Widget bodyWidget(AddRecordModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('主题'),
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
          GlobalConfig.currentTheme().dividerColor.withOpacity(0.2),
          GlobalConfig.currentTheme().dividerColor.withOpacity(0.1)
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("待添加"),
            new Container(
              padding: EdgeInsets.all(10.0),
              child: new Icon(
                Icons.bug_report,
                color: Colors.white,
                size: 130.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
