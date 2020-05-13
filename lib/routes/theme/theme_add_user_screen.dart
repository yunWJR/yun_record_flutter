import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/routes/theme/theme_add_user_model.dart';

class ThemeAddUserScreen extends StatefulWidget {
  static const routeName = "ThemeAddUserScreen";

  @override
  ThemeAddUserScreenState createState() => ThemeAddUserScreenState();
}

class ThemeAddUserScreenState extends State<ThemeAddUserScreen> {
  ThemeVo theme;

  ThemeAddUserModel addUserModel;

  @override
  Widget build(BuildContext context) {
    if (theme == null) {
      theme = ModalRoute.of(context).settings.arguments;
    }

    if (addUserModel == null) {
      addUserModel = ThemeAddUserModel(context, theme);
    }

    return ChangeNotifierProvider<ThemeAddUserModel>(
      create: (context) => addUserModel,
      child: Consumer<ThemeAddUserModel>(
        builder: (context, model, child) => WillPopScope(
          onWillPop: () async {
//            theme.loadData(context);
            return true;
          },
          child: Scaffold(
            body: YunBasePage<ThemeAddUserModel>.page(
              body: bodyWidget(addUserModel),
              model: model,
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(ThemeAddUserModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('添加分享用户'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _addUserOn(model);
            },
          )
        ],
      ),
      body: new Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            itemCount: model.userList?.length != null ? model.userList.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return listItem(model, index);
            },
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Theme.of(context).unselectedWidgetColor,
                height: 1,
                thickness: 0,
              );
            },
          )),
    );
  }

  // region Widget

  Widget listItem(ThemeAddUserModel model, int index) {
    var item = model.userList[index];

    var cell = Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 8,
          child: FlatButton(
            onPressed: () => _userSelOn(model, index),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(Icons.account_circle),
                const SizedBox(width: 8.0),
                Text(item.name),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: IconButton(
            onPressed: () {
              _userSelOn(model, index);
            },
            icon: Icon(item.selected ? Icons.check_circle : Icons.radio_button_unchecked),
          ),
        ),
      ],
    );

    return cell;
  }

  // endregion

  // region Action

  void _userSelOn(ThemeAddUserModel model, int userIndex) {
    model.userSelOn(userIndex);
  }

  _addUserOn(ThemeAddUserModel model) {
    model.addUser().then((suc) {
      if (suc) {
        YunToast.showToast("添加成功", context);
        Navigator.of(context).pop(1);
      }
    });
  }

// endregion

// region private

// endregion
}
