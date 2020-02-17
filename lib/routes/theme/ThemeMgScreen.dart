import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yun_record/common/model/PageBaseNotiModel.dart';
import 'package:yun_record/common/page/BasePage.dart';
import 'package:yun_record/routes/record/RecordModel.dart';

import '../../index.dart';

class ThemeMgScreen extends StatefulWidget {
  @override
  ThemeMgScreenState createState() => ThemeMgScreenState();
}

class ThemeMgScreenState extends State<ThemeMgScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecordModel>(
      builder: (context, model, child) => Scaffold(
        body: BasePage<RecordModel>.page(
          body: bodyWidget(model),
          model: model,
        ),
      ),
    );
  }

  Widget bodyWidget(RecordModel model) {
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
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 70.0, bottom: 20.0),
              child: new Text(
                model.themeDataList != null ? model.themeDataList.length.toString() : "loading",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
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

  Future<void> _onRefresh(BuildContext context, PageBaseNotiModel model) {
    print('_onRefresh');
    final Completer<void> completer = Completer<void>();
    model.refreshData().then((_) {
      if (model.loadingFailed) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('spacex.other.loading_error.message'),
            action: SnackBarAction(
              label: 'spacex.other.loading_error.reload',
              onPressed: () => _onRefresh(context, model),
            ),
          ),
        );
      }
      completer.complete();
    });

    return completer.future;
  }

  Widget _loadingIndicator() => Center(child: const CircularProgressIndicator());
}
