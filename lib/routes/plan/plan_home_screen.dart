import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/config/global_config.dart';
import 'package:yun_record/models/plan_vo.dart';

import 'edit/plan_edit_screen.dart';
import 'plan_model.dart';

class PlanHomeScreen extends StatefulWidget {
  PlanHomeScreen({Key key}) : super(key: key);

  @override
  _PlanHomeScreenState createState() => _PlanHomeScreenState();
}

class _PlanHomeScreenState extends State<PlanHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlanModel>(
      builder: (context, model, child) => Scaffold(
        body: YunBasePage<PlanModel>.page(
          body: bodyWidget(model),
          model: model,
        ),
        floatingActionButton: ClipOval(
            child: Container(
          color: Colors.amber,
          child: IconButton(
            onPressed: () {
              _addPlanOn(model);
            },
            icon: Icon(Icons.add),
            color: Colors.white,
          ),
        )),
      ),
    );
  }

  Widget bodyWidget(PlanModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('计划'),
        //        actions: <Widget>[
        //          IconButton(
        //            icon: Icon(Icons.widgets),
        //            onPressed: () {
        //              _gotoThemeMg(model);
        //            },
        //          )
        //        ],
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
          GlobalConfig.currentTheme().primaryColor.withOpacity(0.02),
          GlobalConfig.currentTheme().primaryColor.withOpacity(0.02)
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
//            _statusWidget(model),
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

//    model.loadList(context);
  }

  void _addPlanOn(PlanModel model) async {
    var rst = await Navigator.pushNamed(context, PlanEditScreen.routeName, arguments: model);
    if (rst != null) {
      model.loadList(context);
    }
  }

  // endregion

  // region Widget

  Widget _blankWidget(PlanModel model) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _noContentWidget(model),
        ),
      ],
    );
  }

  Widget _listWidget(PlanModel model) {
    return ListView.separated(
      itemCount: model.planList.length,
//                    itemExtent: 50.0, //强制高度为50.0
      itemBuilder: (BuildContext context, int index) {
        return _itemWidget(model, index);
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
//          color: Colors.grey.withOpacity(0.5),
          height: 2,
          thickness: 2,
        );
      },
    );
  }

  // 每个条目
  Widget _itemWidget(PlanModel model, int index) {
    PlanVo item = model.planList[index];

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_defPadding()),
          color: item.isCmp()
              ? GlobalConfig.currentTheme().primaryColor.withOpacity(0.3)
              : GlobalConfig.currentTheme().cardColor.withOpacity(0.3),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Checkbox(
                  value: item.isCmp(),
//                  activeColor: item.isCmp() ? GlobalConfig.currentTheme().backgroundColor : Colors.grey, //选中时的颜色
                  onChanged: (value) {
                    itemStatusChanged(model, item);
                  },
                ),
              ),
              Expanded(
                flex: 11,
                child: new Text(item.content),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _defPadding() {
    return 10.0;
  }

  Widget _noContentWidget(PlanModel model) {
    return Container(color: Colors.grey[300], child: Center(child: new Text("无内容")));
  }

  void itemStatusChanged(PlanModel model, PlanVo item) {
    model.changeItemStatus(item);
  }

// endregion
}
