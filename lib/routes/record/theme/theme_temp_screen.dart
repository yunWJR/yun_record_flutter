import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/models/theme_temp_vo.dart';

import 'add_custom_theme_screen.dart';
import 'add_temp_theme_screen.dart';
import 'theme_temp_model.dart';

class ThemeTempScreen extends StatefulWidget {
  static const routeName = "ThemeTempScreen";

  @override
  ThemeTempScreenState createState() => ThemeTempScreenState();
}

class ThemeTempScreenState extends State<ThemeTempScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> argu = ModalRoute.of(context).settings.arguments;

    ThemeTempModel newModel = ThemeTempModel(context);

    return ChangeNotifierProvider<ThemeTempModel>.value(
        value: newModel,
        child: Consumer<ThemeTempModel>(
          builder: (context, model, child) => Scaffold(
            body: YunBasePage<ThemeTempModel>.page(
              body: bodyWidget(model),
              model: model,
            ),
          ),
        ));
  }

  Widget bodyWidget(ThemeTempModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('主题模板列表'),
      ),
      body: new Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            itemCount: model.themeTempList?.length == null ? 1 : model.themeTempList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return _itemWidget(model, index);
            },
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
//                color: Theme.of(context).primaryColor,
                height: 4,
                thickness: 0,
              );
            },
          )),
    );
  }

  // region Widget

  Widget _itemWidget(ThemeTempModel model, int index) {
    // 自定义主题
    if (index == 0) {
      return _customTheme();
    }

    ThemeTempVo value = model.themeTempList[index - 1];

    return _itemTheme(value);
  }

  Widget _customTheme() {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[400],
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.contacts),
                  const SizedBox(width: 4.0),
                  Text('自定义主题'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _customThemeOn,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _itemTheme(ThemeTempVo value) {
    var cell = Container(
        padding: EdgeInsets.all(10),
        color: Theme.of(context).primaryColorLight,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  const SizedBox(width: 4.0),
                  Text("${value.type.name}:${value.name}"),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _themeTempOn(value);
                  },
                ),
              ),
            ),
          ],
        ));

    return cell;
  }

  // endregion

  // region Action

  void _themeTempOn(ThemeTempVo theme) async {
    var rst = await Navigator.pushNamed(context, AddTempThemeScreen.routeName, arguments: theme);
    if (rst != null) {
      Navigator.pop(context, true);
    }
  }

  void _customThemeOn() async {
    var rst = await Navigator.pushNamed(context, AddCustomThemeScreen.routeName, arguments: null);
    if (rst != null) {
      Navigator.pop(context, true);
    }
  }

// endregion

// region private

// endregion

}
