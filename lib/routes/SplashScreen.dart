import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yun_record/common/model/query_model.dart';
import 'package:yun_record/models/Home.dart';

import '../index.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) => bodyWidget(model),
    );
  }

  Widget bodyWidget(HomeModel model) {
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

  Widget loadingWidget(HomeModel model) {
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

  Widget ctWidget(HomeModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('test'),
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
                model.userVo != null ? model.userVo.loginToken : "loading",
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

    return new Stack(children: <Widget>[
      new Container(
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
                model.userVo != null ? model.userVo.loginToken : "loading",
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
    ]);
  }

  Future<void> _onRefresh(BuildContext context, QueryModel model) {
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
