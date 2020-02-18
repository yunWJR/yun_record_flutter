import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yun_record/common/model/PageBaseNotiModel.dart';
import 'package:yun_record/common/page/BasePage.dart';
import 'package:yun_record/routes/record/RecordModel.dart';

import '../../index.dart';

class MyScreen extends StatefulWidget {
  @override
  MyScreenState createState() => MyScreenState();
}

class MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecordModel>(
      builder: (context, model, child) => Scaffold(
        body: BasePage<RecordModel>.page(
          body: ctWidget(model),
          model: model,
        ),
      ),
    );
  }

  Widget bodyWidget(RecordModel model) {
    print(model.isLoading);

    bool isLoading = model.isLoading;

    List<Widget> widgets = new List();

    widgets.add(ctWidget(model));

    widgets.add(Visibility(
      visible: isLoading,
      child: loadingWidget(model),
    ));

    return new Stack(children: widgets);
  }

  Widget loadingWidget(RecordModel model) {
    return new Container(
//          width: MediaQuery.of(context).size.width,
//          height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(100, 100, 100, 0.5),
      child: Center(
        child: const CircularProgressIndicator(
//              backgroundColor: Color.fromRGBO(100, 100, 100, 1),
            ),
      ),
    );
  }

  Widget ctWidget(RecordModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('个人中心'),
        backgroundColor: Theme.of(context).accentColor, // 主题
        ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.teal, Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(child: new Text('设置主题'), onPressed: (){
              Navigator.pushNamed(context, "SettingsScreen");
            }),
            new RaisedButton(child: new Text('退出登录'), onPressed: _logOut),
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

  void _logOut() {
    Navigator.pushNamedAndRemoveUntil(context, "Login", (Route<dynamic> route) => false);
  }
}
