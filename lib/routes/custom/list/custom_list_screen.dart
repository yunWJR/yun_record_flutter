import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/models/custom_vo.dart';
import 'package:yun_record/routes/custom/edit/custom_edit_screen.dart';

import '../custom_model.dart';
import 'custom_list_model.dart';

class CustomListScreen extends StatefulWidget {
  static const routeName = "CustomListScreen";

  @override
  CustomListScreenState createState() => CustomListScreenState();
}

class CustomListScreenState extends State<CustomListScreen> {
  CustomModel homeModel;
  CustomListModel newModel;

  @override
  Widget build(BuildContext context) {
    if (homeModel == null) {
      homeModel = ModalRoute.of(context).settings.arguments;
    }

    if (newModel == null) {
      newModel = CustomListModel(context);
    }

    return ChangeNotifierProvider<CustomListModel>(
      create: (context) => newModel,
      child: Consumer<CustomListModel>(
        builder: (context, model, child) => Scaffold(
          body: YunBasePage<CustomListModel>.page(
            body: bodyWidget(newModel),
            model: model,
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(CustomListModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('我的习惯'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _gotoAddCustom(model);
            },
          )
        ],
      ),
      body: new Container(
        padding: EdgeInsets.all(10),
        //        decoration: BoxDecoration(
        //            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
        //          Theme.of(context).dividerColor.withOpacity(0.2),
        //          Theme.of(context).dividerColor.withOpacity(0.1)
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

  List<Widget> themItems(CustomListModel model) {
    double sw = MediaQuery.of(context).size.width;
    double itemW = (sw - 32) / 3;

    List<Widget> items = List();

    if (model == null || model.customList == null) {
      return items;
    }

    for (var value in model.customList) {
      var cell = Container(
          color: Theme.of(context).primaryColor.withOpacity(0.4),
          child: FlatButton(
            onPressed: () => _itemOn(value),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(value.name),
                const SizedBox(height: 10),
                Text("频率：" + CustomDefine.typeName(value.type)),
              ],
            ),
          ));

      items.add(cell);
    }

    return items;
  }

  // endregion

  // region Action

  void _itemOn(Custom theme) {
    print(theme.name);
    //    Navigator.of(context).pop();
  }

  _gotoAddCustom(CustomListModel model) async {
    var rst = await Navigator.pushNamed(context, CustomEditScreen.routeName, arguments: null);
    if (rst != null) {
      model.loadList(context);
//      homeModel.loadData();
    }
  }

// endregion

// region private

// endregion
}
