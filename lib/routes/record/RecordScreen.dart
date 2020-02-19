import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/action/yun_action.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/models/ThemeDataVo.dart';
import 'package:yun_record/models/ThemeVo.dart';

import 'RecordModel.dart';

class RecordScreen extends StatefulWidget {
  RecordScreen({Key key}) : super(key: key) {
    recordScreen = this;
  }

  static BuildContext context1;
  static RecordScreen recordScreen;

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  YunPageNavigatorOn yunPageOn;
//
//  void logOut() {
//    print('my ctn');
//    print(context);
//    Navigator.pushNamedAndRemoveUntil(context, "Login", (Route<dynamic> route) => false);
//  }

  @override
  Widget build(BuildContext context) {
    RecordScreen.context1 = context;
    return Consumer<RecordModel>(
      builder: (context, model, child) => Scaffold(
        body: YunBasePage<RecordModel>.page(
          body: bodyWidget(model),
          model: model,
        ),
        floatingActionButton: ClipOval(
            child: Container(
          color: Colors.blue,
          child: IconButton(
            onPressed: () {
              _addOn();
            },
            icon: Icon(Icons.add),
            color: Colors.white,
          ),
        )),
      ),
    );
  }

  Widget bodyWidget(RecordModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('记录列表'),
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.white70, Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _statusWidget(model),
            Expanded(
                child: RefreshIndicator(
              child: model.isBlankList() ? _blankWidget(model) : _listWidget(model),
              onRefresh: _handleRefresh,
            )),
          ],
        ),
      ),
    );
  }

  // region action

  // 下拉刷新方法
  Future<Null> _handleRefresh() async {
    print('refresh');
    print(RecordScreen.context1);
    RecordScreen.context1 = context;
    print(RecordScreen.context1);
  }

  _onTheme(RecordModel model) {
    _changeTheme(model);
  }

  Future<void> _changeTheme(RecordModel model) async {
    int index = await YunAction.showAction(context, model.themeList.map((f) => f.name).toList(), title: "请选择主题");

    if (index != null) {
      model.selectTheme(model.themeList[index].id);
    }
  }

  _onDate(RecordModel model) {
    DatePicker.showDatePicker(context,
        showTitleActions: true, minTime: DateTime(1900, 1, 1), maxTime: DateTime(2100, 1, 1), onChanged: (date) {
//      print('change $date');
    }, onConfirm: (date) {
      model.selectDate(date);
    }, currentTime: model.selDate ?? DateTime.now(), locale: LocaleType.zh);
  }

  void _addOn() {
    _setThemeTag();
  }

  void _setThemeTag() async {
    RecordModel model = Provider.of(context, listen: false);

    ThemeVo th = await model.getValidThemeDetails();
    if (th == null || th.tagList.length == 0) {
//      model.showErr('无主题信息');
      return;
    }

    int tagIndex;

    if (th.tagList.length == 1) {
      tagIndex = 0;
    } else {
      tagIndex = await YunAction.showAction(context, th.tagList.map((f) => f.name).toList(), title: "请选择主题");
    }

    if (tagIndex != null) {
      Map<String, dynamic> argu = new Map();
      argu["theme"] = th;
      argu["date"] = model.selDate;
      argu['tag'] = th.tagList[tagIndex];

      var rst = await Navigator.pushNamed(context, "AddRecordScreen", arguments: argu);
      if (rst != null) {
        model.loadList(context);
      }
    }
  }

  // endregion

  // region Widget

  Widget _statusWidget(RecordModel model) {
    double p = _defPadding();

    return new Container(
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
//              margin: EdgeInsets.only(left: p, right: p, top: p, bottom: p),
//              height: 30.0,
              color: Colors.blueGrey[200],
              child: FlatButton.icon(
                icon: Icon(Icons.book),
                label: Text(model.themeText()),
                onPressed: () {
                  _onTheme(model);
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
//              margin: EdgeInsets.only(left: p, right: p, top: p, bottom: p),
//              height: 30.0,
              color: Colors.amber[300],
              child: FlatButton.icon(
                icon: Icon(Icons.date_range),
                label: Text(model.dateText()),
                onPressed: () {
                  _onDate(model);
                },
              ),
            ),
          ),
        ],
      ),
      //      color: Colors.amber,
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
      itemCount: model.themeDataList.length,
//                    itemExtent: 50.0, //强制高度为50.0
      itemBuilder: (BuildContext context, int index) {
        return _itemWidget(model, index);
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.blue,
          height: 2,
        );
      },
    );
  }

  // 每个条目
  Widget _itemWidget(RecordModel model, int index) {
    ThemeDataVo item = model.themeDataList[index];

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_defPadding()),
          color: Colors.black12,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: new Text(item.time),
              ),
              Expanded(
                child: new Text(item.theme.name),
              ),
              Expanded(
                child: new Text(item.name),
              ),
            ],
          ),
        ),
        Container(
            child: Column(
          children: item.propDataList.map<Widget>((PropDataVo f) {
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
                    child: new Text(f.propData.orgValue),
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

// endregion

}
