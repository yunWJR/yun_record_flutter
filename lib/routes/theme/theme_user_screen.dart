import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/TagVo.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/routes/theme/theme_user_model.dart';

class ThemeUserScreen extends StatefulWidget {
  static const routeName = "ThemeUserScreen";

  @override
  ThemeUserScreenState createState() => ThemeUserScreenState();
}

class ThemeUserScreenState extends State<ThemeUserScreen> {
  ThemeVo themeVo;

  ThemeUserModel themeUserMode;

  @override
  Widget build(BuildContext context) {
    if (themeVo == null) {
      themeVo = ModalRoute.of(context).settings.arguments;
    }

    if (themeUserMode == null) {
      themeUserMode = ThemeUserModel(context, themeVo);
    }

    return ChangeNotifierProvider<ThemeUserModel>(
      create: (context) => themeUserMode,
      child: Consumer<ThemeUserModel>(
        builder: (context, model, child) => WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            body: YunBasePage<ThemeUserModel>.page(
              body: bodyWidget(themeUserMode),
              model: model,
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(ThemeUserModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(model.themeVo.name + '的成员管理'),
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

  Widget themItem(ThemeUserModel model, int index) {
    var theme = model.themeList[index];

    List<Widget> items = List();

    var cell = Slidable(
      actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        //右侧按钮列表
        IconSlideAction(
          caption: '成员',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => _themeUserOn(model, theme),
        ),
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: true,
          onTap: () {
            _deleteTheme(model, theme);
          },
        ),
      ],
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: FlatButton(
              onPressed: () => _themeUserOn(model, theme),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  const SizedBox(width: 8.0),
                  Text(theme.name),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () {
                model.changeThemeExpand(theme);
              },
              icon: Icon(theme.isExpand ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_left),
            ),
          ),
        ],
      ),
    );

    items.add(cell);

    if (theme.isExpand && theme.tagList != null) {
      for (var tag in theme.tagList) {
        Widget iH = Slidable(
            actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
            actionExtentRatio: 0.25,
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: '删除',
                color: Colors.red,
                icon: Icons.delete,
                closeOnTap: true,
                onTap: () {
                  _deleteTag(model, tag);
                },
              ),
            ],
            child: Container(
              padding: EdgeInsets.only(left: 30),
              child: FlatButton(
                onPressed: () => _tagOn(model, tag),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(Icons.all_out),
                    const SizedBox(width: 8.0),
                    Text(tag.name),
                  ],
                ),
              ),
            ));

        items.add(iH);
      }
    }

    return Column(
      children: items,
    );
  }

  // endregion

  // region Action

  void _themeUserOn(ThemeUserModel model, ThemeVo theme) {
    //    Navigator.of(context).pop();
  }

  _gotoAddTheme(ThemeUserModel model) async {
//    var rst = await Navigator.pushNamed(context, AddCustomThemeScreen.routeName, arguments: null);
//    if (rst != null) {
//      model.loadData();
////      recordModel.loadData();
//    }
  }

  _deleteTheme(ThemeUserModel model, ThemeVo value) {
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

  void _deleteTag(ThemeUserModel model, TagVo prop) {}

  _tagOn(ThemeUserModel model, TagVo tag) {}

// endregion

// region private

// endregion
}
