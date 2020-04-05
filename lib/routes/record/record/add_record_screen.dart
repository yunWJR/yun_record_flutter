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
    Map<String, dynamic> arg = ModalRoute.of(context).settings.arguments;

    AddRecordModel newModel = AddRecordModel(context);
    newModel.setArgu(arg);

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
//          Theme.of(context).dividerColor.withOpacity(0.1),
//          Theme.of(context).dividerColor.withOpacity(0.2)
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

  void _onDateTime(AddRecordModel model) {
    DatePicker.showDateTimePicker(context,
        currentTime: model.dto.selDate,
        onChanged: (date) {}, onConfirm: (date) {
      model.updateDate(date);
    }, locale: LocaleType.zh);
  }

  void _onTime(AddRecordModel model) {
    DatePicker.showTimePicker(context,
        currentTime: model.dto.selDate,
        onChanged: (date) {}, onConfirm: (date) {
      model.updateTime(date);
    }, locale: LocaleType.zh);
  }

// region action

// endregion

// region Widget

  Widget _statusWidget(AddRecordModel model) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor.withOpacity(0.3),
      child: Column(
        children: <Widget>[
          Container(
            child: FlatButton.icon(
              icon: Icon(Icons.date_range),
              label: Text(model.dateTimeText()),
              onPressed: () {
                _onDateTime(model);
              },
            ),
          ),
          Container(
              color: Theme.of(context).primaryColor.withOpacity(1), height: 1)
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
          color: Theme.of(context).primaryColor.withOpacity(0.4),
          thickness: 1,
          height: 1,
        );
      },
    );
  }

  // 每个条目
  Widget _itemWidget(AddRecordModel model, int index) {
    PropDto item = model.dto.propList[index];

    return Container(
      color: Theme.of(context).selectedRowColor,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: _defPadding() * 2,
                right: _defPadding() * 2,
                top: _defPadding(),
                bottom: _defPadding()),
//            color: Colors.black12,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: new Text("记录项:" + item.prop.name),
                ),
                Expanded(
                  child: new Text("单位:" + item.prop.dataUnit ?? "无"),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(_defPadding()),
//            color: Colors.black12,
              child: TextField(
                autofocus: item.isFirst,
                controller: item.input,
                decoration: InputDecoration(hintText: "请输入内容", filled: true),
              )),
        ],
      ),
    );
  }

  double _defPadding() {
    return 10.0;
  }

// endregion

}
