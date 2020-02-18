import 'package:flutter/material.dart';
import 'package:yun_record/common/page/YunBasePage.dart';
import 'package:yun_record/routes/record/AddRecordModel.dart';

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
        title: new Text('Home'),
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlueAccent, Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(10.0),
              child: new Icon(
                Icons.bubble_chart,
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
