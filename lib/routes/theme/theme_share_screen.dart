import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/ThemeShareItemVo.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/routes/theme/theme_add_user_screen.dart';
import 'package:yun_record/routes/theme/theme_share_model.dart';

class ThemeShareScreen extends StatefulWidget {
  static const routeName = "ThemeShareScreen";

  @override
  ThemeShareScreenState createState() => ThemeShareScreenState();
}

class ThemeShareScreenState extends State<ThemeShareScreen> {
  ThemeVo themeVo;

  ThemeShareModel themeUserMode;

  @override
  Widget build(BuildContext context) {
    if (themeVo == null) {
      themeVo = ModalRoute.of(context).settings.arguments;
    }

    if (themeUserMode == null) {
      themeUserMode = ThemeShareModel(context, themeVo);
    }

    return ChangeNotifierProvider<ThemeShareModel>(
      create: (context) => themeUserMode,
      child: Consumer<ThemeShareModel>(
        builder: (context, model, child) => WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            body: YunBasePage<ThemeShareModel>.page(
              body: bodyWidget(themeUserMode),
              model: model,
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(ThemeShareModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(model.themeVo == null ? "" : (model.themeVo.name + '的分享管理')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _gotoAddShareItem(model);
            },
          )
        ],
      ),
      body: new Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            itemCount: model.itemList?.length != null ? model.itemList.length : 0,
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

  Widget listItem(ThemeShareModel model, int index) {
    var item = model.itemList[index];

    var cell = Slidable(
      actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: true,
          onTap: () {
            _deleteShareItem(model, item);
          },
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(Icons.account_circle),
            const SizedBox(width: 8.0),
            Text(item.businessName),
          ],
        ),
      ),
    );

    return cell;
  }

  // endregion

  // region Action

  _gotoAddShareItem(ThemeShareModel model) async {
    var rst = await Navigator.pushNamed(context, ThemeAddUserScreen.routeName, arguments: model.themeVo);
    if (rst != null) {
      model.loadData();
//      recordModel.loadData();
    }
  }

  _deleteShareItem(ThemeShareModel model, ThemeShareItemVo item) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("删除确认"),
          content: Text("确认删除主题:" + item.businessName + "?"),
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

                model.deleteShareItem(item.id);
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
