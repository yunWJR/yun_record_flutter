import 'package:flutter/material.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/config/global_config.dart';
import 'package:yun_record/config/global_theme_config.dart';

import '../../index.dart';
import 'my_model.dart';

class MyScreen extends StatefulWidget {
  @override
  MyScreenState createState() => MyScreenState();
}

class MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
//    GlobalConfig.nanOn = (String route, bool remove) {
//      _logOutGlobal(route, remove);
//    };

    return Consumer<MyModel>(
      builder: (context, model, child) => Scaffold(
        body: YunBasePage<MyModel>.page(
          body: bodyWidget(model),
          model: model,
        ),
      ),
    );
  }

  Widget bodyWidget(MyModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('个人中心'),
        //        backgroundColor: Theme.of(context).accentColor, // 主题
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
          GlobalThemeConfig.currentTheme().primaryColor.withOpacity(0.04),
          GlobalThemeConfig.currentTheme().primaryColor.withOpacity(0.08)
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 40,
            ),
            ClipOval(
              child: new Container(
                child: Image(
                  image: NetworkImage("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
                  width: 100.0,
                ),
                color: GlobalThemeConfig.currentTheme().primaryColor,
              ),
            ),
            Container(
              height: 10,
            ),
            new Text(GlobalConfig.userVo?.name ?? "无名氏"),
            Container(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[400],
              child: new FlatButton(
                  child: new Text('设置'),
                  onPressed: () {
                    Navigator.pushNamed(context, "SettingsScreen");
                  }),
            ),
            Container(
              height: 4,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[400],
              child: new FlatButton(child: new Text('退出登录'), onPressed: _logOut),
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

  void _logOut() {
    Navigator.pushNamedAndRemoveUntil(context, "Login", (Route<dynamic> route) => false);
  }

//  Future _logOutGlobal(String route, bool remove) async {
//    await Future.delayed(Duration.zero);
//
//    if (remove) {
//      Navigator.pushNamedAndRemoveUntil(context, route, (Route<dynamic> route) => false);
//    } else {
//      Navigator.pushNamed(context, route);
//    }
//  }
}
