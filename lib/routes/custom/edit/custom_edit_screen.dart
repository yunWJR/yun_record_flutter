import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_base/toast/yun_toast.dart';
import 'package:yun_record/models/custom_vo.dart';

import '../../../index.dart';
import 'custom_edit_model.dart';

class CustomEditScreen extends StatefulWidget {
  static const routeName = "CustomEditScreen";

  @override
  _CustomEditScreenState createState() => _CustomEditScreenState();
}

class _CustomEditScreenState extends State<CustomEditScreen> {
  CustomEditModel model;

  @override
  Widget build(BuildContext context) {
    var argu = ModalRoute.of(context).settings.arguments;

    if (model == null) {
      model = CustomEditModel(context, dto: null);
    }

    return ChangeNotifierProvider<CustomEditModel>.value(
        value: model,
        child: Consumer<CustomEditModel>(
          builder: (context, model, child) => Scaffold(
            body: YunBasePage<CustomEditModel>.page(
              body: bodyWidget(model),
              model: model,
            ),
          ),
        ));
  }

  Widget bodyWidget(CustomEditModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(model.dto.id == null ? "添加习惯" : "编辑习惯"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: '保存',
            onPressed: () {
              _saveOn(model);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: new Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(_defPadding()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _itemsWidget(model),
          ),
        ),
      ),
    );
  }

  void _saveOn(CustomEditModel model) {
    FocusScope.of(context).requestFocus(new FocusNode());
    model.saveCustom().then((suc) {
      if (suc) {
        YunToast.showToast("保存成功");
        Navigator.of(context).pop(1);
      }
    });
  }

// region action

// endregion

// region Widget

  // 每个条目
  Widget _itemWidget(CustomEditModel model) {
    Custom item = model.dto;

    return Column(
      children: <Widget>[
        Container(child: item.nameTf),
      ],
    );
  }

  List<Widget> _itemsWidget(CustomEditModel model) {
    double p = 14;

    Custom item = model.dto;

    List<Widget> items = List();

    items.add(Form(
      key: item.nameFormKey,
      autovalidate: item.autoValidate,
      child: item.nameTf,
    ));

    items.add(Container(
      padding: EdgeInsets.only(top: p, bottom: p),
      alignment: Alignment.centerLeft,
      child: Text(
        "频率",
      ),
    ));
    items.add(ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity, //宽度尽可能大
      ),
      child: Wrap(
        spacing: 4.0,
        // 主轴(水平)方向间距
        runSpacing: 2.0,
        // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start,
        //沿主轴方向居中
        direction: Axis.horizontal,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: _typeItems(model),
      ),
    ));

    items.add(Container(
      padding: EdgeInsets.only(top: p, bottom: p),
      alignment: Alignment.centerLeft,
      child: Text(
        "完成目标",
      ),
    ));
    items.add(ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity, //宽度尽可能大
      ),
      child: Wrap(
        spacing: 4.0,
        // 主轴(水平)方向间距
        runSpacing: 2.0,
        // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start,
        //沿主轴方向居中
        direction: Axis.horizontal,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: _cmpItems(model),
      ),
    ));
    items.add(Container(
      padding: EdgeInsets.only(top: p, bottom: p),
      alignment: Alignment.centerLeft,
      child: Text(
        "完成目标数量",
      ),
    ));
    items.add(Form(
      key: item.completeParaFormKey,
      autovalidate: item.autoValidate,
      child: item.completeParaTf,
    ));

    return items;
  }

  List<Widget> _typeItems(CustomEditModel model) {
    List<Widget> items = List();

    for (int i = 1; i <= 2; i++) {
      bool isSel = false;
      if (model.dto.type != null) {
        isSel = model.dto.type == i;
      }

      var cell = Container(
//          color: isSel ? Theme.of(context).primaryColor : Theme.of(context).selectedRowColor,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: isSel
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).unselectedWidgetColor.withOpacity(0.3),
              border: Border.all(
                  color: isSel
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  width: 1)),
          child: FlatButton(
            child: Text(i == 1 ? "每日" : "每周"),
//            color: Colors.red,
//            shape: RoundedRectangleBorder(),
            onPressed: () => _changeType(model, i),
          ));

      items.add(cell);
    }

    return items;
  }

  void _changeType(CustomEditModel model, int type) {
    if (model.dto.type != null && model.dto.type == type) {
      return;
    }

    model.dto.type = type;

    model.notifyListeners();

    // 更新
  }

  List<Widget> _cmpItems(CustomEditModel model) {
    List<Widget> items = List();

    for (int i = 1; i <= 2; i++) {
      bool isSel = false;
      if (model.dto.completeType != null) {
        isSel = model.dto.completeType == i;
      }

      var cell = Container(
//          color: isSel ? Theme.of(context).primaryColor : Theme.of(context).selectedRowColor,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: isSel
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).unselectedWidgetColor.withOpacity(0.3),
              border: Border.all(
                  color: isSel
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  width: 1)),
          child: FlatButton(
            child: Text(i == 1 ? "次数" : "总量"),
//            color: Colors.red,
//            shape: RoundedRectangleBorder(),
            onPressed: () => _changeCmpType(model, i),
          ));

      items.add(cell);
    }

    return items;
  }

  void _changeCmpType(CustomEditModel model, int type) {
    if (model.dto.completeType != null && model.dto.completeType == type) {
      return;
    }

    model.dto.completeType = type;

    model.notifyListeners();

    // 更新
  }

  double _defPadding() {
    return 10.0;
  }

// endregion

}
