import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yun_record/common/page/BasePage.dart';
import 'package:yun_record/models/ThemeDataVo.dart';
import 'package:yun_record/routes/home/HomeModel.dart';

import '../../index.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) => Scaffold(
        body: BasePage<HomeModel>.page(
          body: bodyWidget(model),
          model: model,
        ),
      ),
    );
  }

  Widget bodyWidget(HomeModel model) {
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
            statusWidget(model),
            Expanded(
                child: RefreshIndicator(
              child: model.isBlankList() ? blankWidget(model) : listWidget(model),
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
  }

  _onTheme(HomeModel model) {}

  _onDate(HomeModel model) {}

  // endregion

  // region Widget

  Widget statusWidget(HomeModel model) {
    double p = defPadding();

    return new Container(
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: p, right: p, top: p, bottom: p),
//              height: 30.0,
              color: Colors.red,
              child: FlatButton.icon(
                icon: Icon(Icons.info),
                label: Text(model.themeText()),
                onPressed: _onTheme(model),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: p, right: p, top: p, bottom: p),
//              height: 30.0,
              color: Colors.green,
              child: FlatButton.icon(
                icon: Icon(Icons.add),
                label: Text(model.dateText()),
                onPressed: _onDate(model),
              ),
            ),
          ),
        ],
      ),
      color: Colors.teal,
    );
  }

  Widget blankWidget(HomeModel model) {
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("无内容"),
          ),
        ),
      ],
    );
  }

  Widget listWidget(HomeModel model) {
    return ListView.separated(
      itemCount: model.themeDataList.length,
//                    itemExtent: 50.0, //强制高度为50.0
      itemBuilder: (BuildContext context, int index) {
        return itemWidget(model, index);
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
  Widget itemWidget(HomeModel model, int index) {
    ThemeDataVo item = model.themeDataList[index];

    print(item.toJson());

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(defPadding()),
          color: Colors.white70,
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
              padding: EdgeInsets.all(defPadding()),
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

  double defPadding() {
    return 10.0;
  }

// endregion
}
