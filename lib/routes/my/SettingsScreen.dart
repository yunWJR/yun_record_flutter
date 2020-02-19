import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_record/config/GlobalConfig.dart';
import 'package:yun_record/config/GlobalConfigNoti.dart';
import 'package:yun_record/config/theme_config.dart';
import 'package:yun_record/widgets/dialog_round.dart';
import 'package:yun_record/widgets/header_text.dart';
import 'package:yun_record/widgets/radio_cell.dart';

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
            HeaderText("主题"),
            new RaisedButton(
                child: new Text('设置主题'),
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => RoundDialog(
                        title: "选择主题",
                        children: themItems(),
                      ),
                    )),
            HeaderText("字体"),
            new RaisedButton(
                child: new Text('设置字体大小'),
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => RoundDialog(
                        title: "选择字体大小",
                        children: fontSizeItems(),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  List<Widget> themItems() {
    List<Widget> items = List();

    for (var value in Themes.values) {
      var cell = RadioCell<Themes>(
        title: value.toString().substring(7),
        groupValue: _themeIndex,
        value: value,
        onChanged: (value) => _changeTheme(value),
      );

      items.add(cell);
    }

    return items;
  }

  void _changeTheme(Themes theme) {
    ThemeGcn gcn = Provider.of<ThemeGcn>(context, listen: false);

    gcn.setThemeIndex(theme);

    setState(() => _themeIndex = theme);

    Navigator.of(context).pop();
  }

  List<Widget> fontSizeItems() {
    List<Widget> items = List();

    for (int i = 0; i < ThemeConfig.fontSizeItems.length; i++) {
      double fs = ThemeConfig.fontSizeItems[i];
      var cell = RadioCell<int>(
        title: fs.toString(),
        groupValue: _fontIndex,
        value: i,
        onChanged: (value) => _changeFont(value),
      );

      items.add(cell);
    }

    return items;
  }

  void _changeFont(int font) {
    ThemeGcn gcn = Provider.of<ThemeGcn>(context, listen: false);

    gcn.setFontSizeIndex(font);

    setState(() => _fontIndex = font);

    Navigator.of(context).pop();
  }
}
