import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_base/toast/yun_toast.dart';
import 'package:yun_record/models/record_dto.dart';

import '../../../index.dart';
import 'add_record_model.dart';

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> argu = ModalRoute.of(context).settings.arguments;

    AddRecordModel newModel = AddRecordModel(context);
    newModel.setArgu(argu);

    return ChangeNotifierProvider<AddRecordModel>.value(
        value: newModel,
        child: Consumer<AddRecordModel>(
          builder: (context, model, child) => Scaffold(
            body: YunBasePage<AddRecordModel>.page(
              body: bodyWidget(model),
              model: model,
            ),
          ),
        ));
  }

  Widget bodyWidget(AddRecordModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('添加记录'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: '保存记录',
            onPressed: () {
              _saveOn(model);
            },
          ),
        ],
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
//        decoration: BoxDecoration(
//            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
//          GlobalThemeConfig.currentTheme().dividerColor.withOpacity(0.1),
//          GlobalThemeConfig.currentTheme().dividerColor.withOpacity(0.2)
//        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _statusWidget(model),
            Expanded(child: _listWidget(model)),
          ],
        ),
      ),
    );
  }

  void _saveOn(AddRecordModel model) {
    model.saveRecord().then((suc) {
      if (suc) {
        YunToast.showToast("保存成功");
        Navigator.of(context).pop(1);
      }
    });
  }

  void _onTime(AddRecordModel model) {
    DatePicker.showTimePicker(context, currentTime: model.dto.selDate, onChanged: (date) {
//      print('change $date');
    }, onConfirm: (date) {
      model.updateTime(date);
    }, locale: LocaleType.zh);
  }

// region action

// endregion

// region Widget

  Widget _statusWidget(AddRecordModel model) {
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
              color: Colors.amber[200],
              child: FlatButton.icon(
                icon: Icon(Icons.date_range),
                label: Text(model.timeText()),
                onPressed: () {
                  _onTime(model);
                },
              ),
            ),
          ),
        ],
      ),
      //      color: Colors.amber,
    );
  }

  Widget _listWidget(AddRecordModel model) {
    return ListView.separated(
      itemCount: model.dto.propList.length,
//                    itemExtent: 50.0, //强制高度为50.0
      itemBuilder: (BuildContext context, int index) {
        return _itemWidget(model, index);
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.blue,
          thickness: 2,
          height: 2,
        );
      },
    );
  }

  // 每个条目
  Widget _itemWidget(AddRecordModel model, int index) {
    PropDto item = model.dto.propList[index];

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_defPadding()),
          color: Colors.black12,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: new Text(item.prop.name),
              ),
              Expanded(
                child: new Text(item.prop.dataUnit ?? ""),
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.all(_defPadding()),
//            color: Colors.black12,
            child: TextField(
              controller: item.input,
              decoration: InputDecoration(hintText: "请输入内容", filled: true),
            )),
      ],
    );
  }

  double _defPadding() {
    return 10.0;
  }

// endregion

}
