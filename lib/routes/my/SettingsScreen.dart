import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_record/config/GlobalConfig.dart';
import 'package:yun_record/config/GlobalConfigNoti.dart';
import 'package:yun_record/widgets/dialog_round.dart';
import 'package:yun_record/widgets/header_text.dart';
import 'package:yun_record/widgets/radio_cell.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Settings indexes
  Themes _themeIndex;

  @override
  void initState() {
    // Get the app theme & image quality from the 'AppModel' model.
    Future.delayed(Duration.zero, () async {
      _themeIndex = Provider.of<ThemeGcn>(context, listen: false).theme;
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
        backgroundColor: Theme.of(context).accentColor,
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
                        children: <Widget>[
                          RadioCell<Themes>(
                            title: 'dark',
                            groupValue: _themeIndex,
                            value: Themes.dark,
                            onChanged: (value) => _changeTheme(value),
                          ),
                          RadioCell<Themes>(
                            title: 'black',
                            groupValue: _themeIndex,
                            value: Themes.black,
                            onChanged: (value) => _changeTheme(value),
                          ),
                          RadioCell<Themes>(
                            title: 'light',
                            groupValue: _themeIndex,
                            value: Themes.light,
                            onChanged: (value) => _changeTheme(value),
                          ),
                          RadioCell<Themes>(
                            title: 'system',
                            groupValue: _themeIndex,
                            value: Themes.system,
                            onChanged: (value) => _changeTheme(value),
                          ),
                        ],
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  void _changeTheme(Themes theme) {
    ThemeGcn gcn = Provider.of<ThemeGcn>(context, listen: false);

    gcn.setThemeIndex(theme);

    // Updates UI
    setState(() => _themeIndex = theme);

    // Hides dialog
    Navigator.of(context).pop();
  }
}
