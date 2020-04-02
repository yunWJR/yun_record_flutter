import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/models/custom_data_vo.dart';
import 'package:yun_record/routes/record/home_calendar.dart';

import 'custom_model.dart';

class CustomHomeScreen extends StatefulWidget {
  CustomHomeScreen({Key key}) : super(key: key);

  @override
  _CustomHomeScreenState createState() => _CustomHomeScreenState();
}

class _CustomHomeScreenState extends State<CustomHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: new Text('习惯'),
          //        actions: <Widget>[
          //          IconButton(
          //            icon: Icon(Icons.widgets),
          //            onPressed: () {
          //              _gotoThemeMg(model);
          //            },
          //          )
          //        ],
        ),
        body: YunBasePage<CustomModel>.page(
          body: bodyWidget(model),
          model: model,
        ),
        //        floatingActionButton: ClipOval(
        //            child: Container(
        //          color: Colors.amber,
        //          child: IconButton(
        //            onPressed: () {
        //              _addRecordOn();
        //            },
        //            icon: Icon(Icons.add),
        //            color: Colors.white,
        //          ),
        //        )),
      ),
    );
  }

  Widget bodyWidget(CustomModel model) {
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
  Future<void> _handleRefresh(CustomModel model) async {
    await model.loadData(context);
  }

  _onDate(CustomModel model) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime(2100, 1, 1),
        onChanged: (date) {}, onConfirm: (date) {
      model.selectDate(date);
    }, currentTime: model.selDate ?? DateTime.now(), locale: LocaleType.zh);
  }

  // endregion

  // region Widget

  Widget _statusWidget(CustomModel model) {
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

  Widget _blankWidget(CustomModel model) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _noContentWidget(model),
        ),
      ],
    );
  }

  Widget _listWidget(CustomModel model) {
    return ListView.separated(
      itemCount: model.customDataList.length,
//                    itemExtent: 50.0, //强制高度为50.0
      itemBuilder: (BuildContext context, int index) {
        return _itemWidget(model, index);
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Theme.of(context).primaryColor,
          height: 2,
          thickness: 2,
        );
      },
    );
  }

  // 每个条目
  Widget _itemWidget(CustomModel model, int index) {
    CustomDataVo item = model.customDataList[index];

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_defPadding()),
          color: item.isCmp()
              ? Theme.of(context).primaryColor.withOpacity(0.3)
              : Theme.of(context).cardColor.withOpacity(0.3),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Checkbox(
                  value: item.isCmp(),
//                  activeColor: item.isCmp() ? Theme.of(context).backgroundColor : Colors.grey, //选中时的颜色
                  onChanged: (value) {
                    itemStatusChanged(model, item);
                  },
                ),
              ),
              Expanded(
                flex: 11,
                child: new Text(item.custom.name),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void itemStatusChanged(CustomModel model, CustomDataVo item) {
    model.itemOn(item);
  }

  double _defPadding() {
    return 10.0;
  }

  Widget _noContentWidget(CustomModel model) {
    return Container(color: Colors.grey[300], child: Center(child: new Text("无内容")));
  }

// endregion
}
