import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/routes/record/record_model.dart';
import 'package:yun_record/routes/theme/theme_list_model.dart';
import 'package:yun_record/routes/theme/theme_temp_screen.dart';

class ThemeListScreen extends StatefulWidget {
  static const routeName = "ThemeListScreen";

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
        builder: (context, model, child) => WillPopScope(
          onWillPop: () async {
            recordModel.loadData(context);
            return true;
          },
          child: Scaffold(
            body: YunBasePage<ThemeListModel>.page(
              body: bodyWidget(themeListModel),
              model: model,
            ),
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
//          padding: EdgeInsets.all(10),
//        decoration: BoxDecoration(
//            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
//          Theme.of(context).dividerColor.withOpacity(0.2),
//          Theme.of(context).dividerColor.withOpacity(0.1)
//        ])),
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            itemCount: model.themeList?.length != null ? model.themeList.length : 1,
            itemBuilder: (BuildContext context, int index) {
              return themItem(model, index);
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

  Widget themItem(ThemeListModel model, int index) {
    var value = model.themeList[index];

    var cell = Slidable(
        actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
        actionExtentRatio: 0.25,
        secondaryActions: <Widget>[
          //右侧按钮列表
          IconSlideAction(
            caption: '详情',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () => _deleteTheme(model, value),
          ),
          IconSlideAction(
            caption: '删除',
            color: Colors.red,
            icon: Icons.delete,
            closeOnTap: true,
            onTap: () {
              _deleteTheme(model, value);
            },
          ),
        ],
        child: FlatButton(
          onPressed: () => _themeOn(value),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.ac_unit),
              const SizedBox(width: 8.0),
              Text(value.name),
            ],
          ),
        ));

    return cell;
  }

  // endregion

  // region Action

  void _themeOn(ThemeVo theme) {
    //    Navigator.of(context).pop();
  }

  _gotoAddTheme(ThemeListModel model) async {
    var rst = await Navigator.pushNamed(context, ThemeTempScreen.routeName, arguments: null);
    if (rst != null) {
      model.loadData();
      recordModel.loadData();
    }
  }

  _deleteTheme(ThemeListModel model, ThemeVo value) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("删除确认"),
          content: Text("确认删除主题:" + value.name + "?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);

                model.deleteTheme(value.id);
              },
            ),
          ],
        );
      },
    );
  }

// endregion

// region private

// endregion
}
