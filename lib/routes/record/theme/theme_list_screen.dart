import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/config/global_config.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/routes/record/record_model.dart';
import 'package:yun_record/routes/record/theme/theme_list_model.dart';
import 'package:yun_record/routes/record/theme/theme_temp_screen.dart';

class ThemeListScreen extends StatefulWidget {
  static const routeName = "MgThemeScreen";

  @override
  ThemeListScreenState createState() => ThemeListScreenState();
}

class ThemeListScreenState extends State<ThemeListScreen> {
  RecordModel recordModel;

  ThemeListModel themeListModel;

  @override
  Widget build(BuildContext context) {
    if (recordModel == null) {
      recordModel = ModalRoute.of(context).settings.arguments;
    }

    if (themeListModel == null) {
      themeListModel = ThemeListModel(context, recordModel.themeList);
    }

    return ChangeNotifierProvider<ThemeListModel>(
      create: (context) => themeListModel,
      child: Consumer<ThemeListModel>(
        builder: (context, model, child) => Scaffold(
          body: YunBasePage<ThemeListModel>.page(
            body: bodyWidget(themeListModel),
            model: model,
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(ThemeListModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('我的主题'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _gotoAddTheme(model);
            },
          )
        ],
      ),
      body: new Container(
        padding: EdgeInsets.all(10),
        //        decoration: BoxDecoration(
        //            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
        //          GlobalConfig.currentTheme().dividerColor.withOpacity(0.2),
        //          GlobalConfig.currentTheme().dividerColor.withOpacity(0.1)
        //        ])),
        width: MediaQuery.of(context).size.width,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //横轴三个子widget
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0 //宽高比为1时，子widget
              ),
          children: themItems(model),
        ),
      ),
    );
  }

  // region Widget

  List<Widget> themItems(ThemeListModel model) {
    double sw = MediaQuery.of(context).size.width;
    double itemW = (sw - 32) / 3;

    List<Widget> items = List();

    if (model == null || model.themeList == null) {
      return items;
    }

    for (var value in model.themeList) {
      var cell = Container(
          color: GlobalConfig.currentTheme().primaryColor.withOpacity(0.4),
          child: FlatButton(
            onPressed: () => _themeOn(value),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.ac_unit),
                const SizedBox(height: 8.0),
                Text(value.name),
              ],
            ),
          ));

      items.add(cell);
    }

    return items;
  }

  // endregion

  // region Action

  void _themeOn(ThemeVo theme) {
    print(theme.name);
    //    Navigator.of(context).pop();
  }

  _gotoAddTheme(ThemeListModel model) async {
    var rst = await Navigator.pushNamed(context, ThemeTempScreen.routeName, arguments: null);
    if (rst != null) {
      model.loadData();
      recordModel.loadData();
    }
  }

// endregion

// region private

// endregion
}
