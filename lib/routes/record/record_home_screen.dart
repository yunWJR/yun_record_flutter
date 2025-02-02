import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/action/yun_action.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/TagDataVo.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/routes/record/record/add_record_screen.dart';
import 'package:yun_record/routes/record/tag/theme_tag_list_screen.dart';
import 'package:yun_record/routes/theme/record_drawer_left.dart';

import 'home_calendar.dart';
import 'record_model.dart';

class RecordHomeScreen extends StatefulWidget {
  RecordHomeScreen({Key key}) : super(key: key);

  @override
  _RecordHomeScreenState createState() => _RecordHomeScreenState();
}

class _RecordHomeScreenState extends State<RecordHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.account_balance_wallet),
//              onPressed: () {
//                _handlerDrawerButton(model);
//              },
//            ),
            IconButton(
              icon: Icon(Icons.widgets),
              onPressed: () {
                _gotoTagList(model);
              },
            )
          ],
          title: new Text("记录-" + model.themeText()),
        ),
        body: YunBasePage<RecordModel>.page(
          body: bodyWidget(model),
          model: model,
        ),
        drawer: new RecordDrawerLeft(model),
        floatingActionButton: ClipOval(
            child: Container(
          color: Theme.of(context).primaryColor,
          child: IconButton(
            onPressed: () {
              _addRecordOn();
            },
            icon: Icon(Icons.add),
            color: Theme.of(context).selectedRowColor,
          ),
        )),
      ),
    );
  }

  Widget bodyWidget(RecordModel model) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
        Theme.of(context).primaryColor.withOpacity(0.02),
        Theme.of(context).primaryColor.withOpacity(0.02)
      ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _statusWidget(model),
          Expanded(
              child: RefreshIndicator(
            child: model.isBlankList() ? _blankWidget(model) : _listWidget(model),
            onRefresh: () => _handleRefresh(model),
          )),
        ],
      ),
    );
  }

  // region action

  // 下拉刷新方法
  Future<void> _handleRefresh(RecordModel model) async {
    await model.loadList(context);
  }

  void _addRecordOn() {
    _setThemeTag();
  }

  void _setThemeTag() async {
    RecordModel model = Provider.of(context, listen: false);

    ThemeVo selTheme = model.selTheme;

    if (selTheme == null) {
      int index = await YunAction.showAction(context, model.themeList.map((f) => f.name).toList(), title: "请选择主题");

      if (index != null) {
        selTheme = model.themeList[index];
      } else {
        return;
      }
    }

    if (selTheme.tagList == null || selTheme.tagList.length == 0) {
      model.showErr('无记录标签');
      return;
    }

    int tagIndex;

    if (selTheme.tagList.length == 1) {
      tagIndex = 0;
    } else {
      tagIndex = await YunAction.showAction(context, selTheme.tagList.map((f) => f.name).toList(), title: "请选择主题");
    }

    if (tagIndex != null) {
      DateTime nDt = DateTime.now();
      if (model.selDate != null) {
        nDt = DateTime(model.selDate.year, model.selDate.month, model.selDate.day, nDt.hour, nDt.minute, nDt.second);
      }

      Map<String, dynamic> argu = new Map();
      argu["theme"] = selTheme;
      argu["date"] = nDt;
      argu['tag'] = selTheme.tagList[tagIndex];

      var rst = await Navigator.pushNamed(context, AddRecordScreen.routeName, arguments: argu);
      if (rst != null) {
        model.loadList(context);
      }
    }
  }

  void _gotoTagList(RecordModel model) async {
    var rst = await Navigator.pushNamed(context, ThemeTagListScreen.routeName, arguments: model);
    if (rst != null) {
      model.loadList(context);
    }
  }

  // endregion

  // region Widget

  Widget _statusWidget(RecordModel model) {
    return Column(
      children: <Widget>[
        Container(
//      color: Theme.of(context).primaryColor.withOpacity(0.3),
          child: HomeCalendar(model.selDate, (DateTime dateTime) {
            model.selectDate(dateTime);
          }),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: 0.5,
          color: Colors.grey[400],
        ),
      ],
    );
  }

  Widget _blankWidget(RecordModel model) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _noContentWidget(model),
        ),
      ],
    );
  }

  Widget _listWidget(RecordModel model) {
    return ListView.separated(
      itemCount: model.tagDataList.length,
//                    itemExtent: 50.0, //强制高度为50.0
      itemBuilder: (BuildContext context, int index) {
        return _itemWidget(model, index);
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          height: 1,
          thickness: 1,
        );
      },
    );
  }

  // 每个条目
  Widget _itemWidget(RecordModel model, int index) {
    TagDataVo item = model.tagDataList[index];

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_defPadding()),
          color: Colors.black12,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: new Text("主题:" + item.theme.name),
              ),
              Expanded(
                child: new Text("标签:" + item.name),
              ),
              Expanded(
                child: new Text(
                  item.time,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
        Container(
            child: Column(
          children: item.propDataList.map<Widget>((PropDataVoNew f) {
            return Container(
              padding: EdgeInsets.all(_defPadding()),
//              color: Colors.amberAccent,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: new Text(f.prop.name),
                  ),
                  Expanded(
                    flex: 4,
                    child: new Text(
                      f.propData.orgValue,
                      style: TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  double _defPadding() {
    return 10.0;
  }

  Widget _noContentWidget(RecordModel model) {
    return Container(color: Colors.grey[300], child: Center(child: new Text("无内容")));
  }

  void _handlerDrawerButton(RecordModel model) {
    YunLog.logData("_handlerDrawerButton");
    Scaffold.of(context).openDrawer();
  }

// endregion
}
