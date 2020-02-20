import 'package:flutter/material.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/config/global_config.dart';
import 'package:yun_record/models/theme_temp_vo.dart';

import '../../index.dart';
import 'add_theme_model.dart';

class AddThemeScreen extends StatefulWidget {
  @override
  AddThemeScreenState createState() => AddThemeScreenState();
}

class AddThemeScreenState extends State<AddThemeScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> argu = ModalRoute.of(context).settings.arguments;

    AddThemeModel newModel = AddThemeModel(context);
//    newModel.setArgu(argu);

    return ChangeNotifierProvider<AddThemeModel>.value(
        value: newModel,
        child: Consumer<AddThemeModel>(
          builder: (context, model, child) => Scaffold(
            body: YunBasePage<AddThemeModel>.page(
              body: bodyWidget(model),
              model: model,
            ),
          ),
        ));
  }

  Widget bodyWidget(AddThemeModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('添加主题'),
      ),
      body: new Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            itemCount: model.themeTempList?.length + 1 ?? 1,
//                    itemExtent: 50.0, //强制高度为50.0
            itemBuilder: (BuildContext context, int index) {
              return _itemWidget(model, index);
            },
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
//                color: GlobalConfig.currentTheme().primaryColor,
                height: 4,
                thickness: 0,
              );
            },
          )),
    );
  }

  Widget _itemWidget(AddThemeModel model, int index) {
    // 自定义主题
    if (index == 0) {
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
                    onPressed: _newThemeOn,
                  ),
                ),
              ),
            ],
          ));
    }

    ThemeTempVo value = model.themeTempList[index - 1];

    var cell = Container(
        padding: EdgeInsets.all(10),
        color: GlobalConfig.currentTheme().primaryColorLight,
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
                  onPressed: () => _themeOn(value),
                ),
              ),
            ),
          ],
        ));

    return cell;
  }

  void _themeOn(ThemeTempVo theme) {
    print(theme.name);
//    Navigator.of(context).pop();
  }

  void _newThemeOn() {
    print('_newThemeOn');
//    Navigator.of(context).pop();
  }
}
