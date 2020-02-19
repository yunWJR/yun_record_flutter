import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_record/config/global_config.dart';
import 'package:yun_record/config/global_config_noti.dart';
import 'package:yun_record/config/theme_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Themes _themeIndex;
  int _fontIndex;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _themeIndex = Provider.of<ThemeGcn>(context, listen: false).theme;
      _fontIndex = Provider.of<ThemeGcn>(context, listen: false).fontIndex;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设置',
          style: TextStyle(fontFamily: 'ProductSans'),
        ),
        centerTitle: true,
        //        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Consumer<ThemeGcn>(
        builder: (context, model, child) => ListView(
          children: <Widget>[
            _header("主题颜色"),
            Wrap(
              spacing: 8.0, // 主轴(水平)方向间距
              runSpacing: 4.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.center, //沿主轴方向居中
              children: themItems(),
            ),
            Container(
              height: 10,
              child: null,
            ),
            _header("文字大小"),
            Wrap(
              spacing: 8.0, // 主轴(水平)方向间距
              runSpacing: 4.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.center, //沿主轴方向居中
              children: fontSizeItems(),
            ),
//            new RaisedButton(
//                child: new Text('设置字体大小'),
//                onPressed: () => showDialog(
//                      context: context,
//                      builder: (context) => RoundDialog(
//                        title: "选择字体大小",
//                        children: fontSizeItems(),
//                      ),
//                    )),
          ],
        ),
      ),
    );
  }

  Widget _header(String title) {
    return Container(
        color: GlobalConfig.currentTheme().primaryColorLight,
        margin: EdgeInsets.only(top: 0, bottom: 10),
        padding: EdgeInsets.all(10),
        child: Center(child: Text(title)));
  }

  List<Widget> themItems() {
    double sw = MediaQuery.of(context).size.width;
    double itemW = (sw - 32) / 3;
    if (itemW < 100) {
      itemW = 100;
    }

    List<Widget> items = List();

    for (var value in Themes.values) {
      ThemeData themeData = GlobalConfig.themeOfIndex(value);

      var cell = Container(
          width: GlobalConfig.fontFactor() * itemW,
          decoration: BoxDecoration(
              color: themeData.primaryColor,
              border: Border.all(color: value == _themeIndex ? Colors.black : Colors.transparent, width: 4)),
          child: FlatButton(
            child: Text(value.toString().substring(7)),
//            color: themeData.primaryColor,
            shape: RoundedRectangleBorder(),
            onPressed: () => _changeTheme(value),
          ));

      items.add(cell);
    }

    return items;
  }

  void _changeTheme(Themes theme) {
    ThemeGcn gcn = Provider.of<ThemeGcn>(context, listen: false);

    gcn.setThemeIndex(theme);

    setState(() => _themeIndex = theme);

//    Navigator.of(context).pop();
  }

  List<Widget> fontSizeItems() {
    double sw = MediaQuery.of(context).size.width;
    double itemW = (sw - 40) / 4;
    if (itemW < 60) {
      itemW = 60;
    }

    List<Widget> items = List();

    for (int i = 0; i < ThemeConfig.fontSizeItems.length; i++) {
      double value = ThemeConfig.fontSizeItems[i];

      var cell = Container(
          width: itemW,
          decoration: BoxDecoration(
              color: i == _fontIndex ? GlobalConfig.currentTheme().primaryColor : Colors.grey[300],
              border: Border.all(color: i == _fontIndex ? Colors.black : Colors.transparent, width: 4)),
          child: FlatButton(
            child: Text(value.toString() + "号"),
//            color: themeData.primaryColor,
            shape: RoundedRectangleBorder(),
            onPressed: () => _changeFont(i),
          ));

      items.add(cell);
    }

    return items;
  }

  void _changeFont(int font) {
    ThemeGcn gcn = Provider.of<ThemeGcn>(context, listen: false);

    gcn.setFontSizeIndex(font);

    setState(() => _fontIndex = font);

//    Navigator.of(context).pop();
  }
}
