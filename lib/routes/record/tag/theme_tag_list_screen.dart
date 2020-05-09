import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/TagVo.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/routes/record/record_model.dart';
import 'package:yun_record/routes/record/tag/theme_tag_list_model.dart';

import 'add_tag_screen.dart';

class ThemeTagListScreen extends StatefulWidget {
  static const routeName = "ThemeTagListScreen";

  @override
  ThemeTagListScreenState createState() => ThemeTagListScreenState();
}

class ThemeTagListScreenState extends State<ThemeTagListScreen> {
  RecordModel recordModel;

  ThemeTagListModel themeListModel;

  @override
  Widget build(BuildContext context) {
    if (recordModel == null) {
      recordModel = ModalRoute.of(context).settings.arguments;
    }

    if (themeListModel == null) {
      themeListModel = ThemeTagListModel(context, recordModel.themeList);
    }

    return ChangeNotifierProvider<ThemeTagListModel>(
      create: (context) => themeListModel,
      child: Consumer<ThemeTagListModel>(
        builder: (context, model, child) => WillPopScope(
          onWillPop: () async {
            recordModel.loadData(context);
            return true;
          },
          child: Scaffold(
            body: YunBasePage<ThemeTagListModel>.page(
              body: bodyWidget(themeListModel),
              model: model,
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(ThemeTagListModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('我的记录'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _gotoAddTag(model);
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
      floatingActionButton: ClipOval(
          child: Container(
        color: Theme.of(context).primaryColor,
        child: IconButton(
          onPressed: () {
            _changeExpandAll(model);
          },
          icon: Icon(model.isExpandAll ? Icons.format_align_right : Icons.reorder),
          color: Theme.of(context).selectedRowColor,
        ),
      )),
    );
  }

  // region Widget

  Widget themItem(ThemeTagListModel model, int index) {
    var theme = model.themeList[index];

    List<Widget> items = List();

    var cell = Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 8,
          child: FlatButton(
            onPressed: () => _themeOn(model, theme),
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

  void _themeOn(ThemeTagListModel model, ThemeVo theme) {
    //    Navigator.of(context).pop();
  }

  _gotoAddTag(ThemeTagListModel model) async {
    var rst = await Navigator.pushNamed(context, AddTagScreen.routeName, arguments: model.themeList);
    if (rst != null) {
      model.loadData();
    }
  }

  _deleteTheme(ThemeTagListModel model, ThemeVo value) {
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

  void _deleteTag(ThemeTagListModel model, TagVo prop) {}

  _tagOn(ThemeTagListModel model, TagVo tag) {}

  void _changeExpandAll(ThemeTagListModel model) {
    model.changeExpandAll();
  }

// endregion

// region private

// endregion
}
