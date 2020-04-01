import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_base/toast/yun_toast.dart';
import 'package:yun_record/models/plan_vo.dart';

import '../../../index.dart';
import 'plan_edit_model.dart';

class PlanEditScreen extends StatefulWidget {
  static const routeName = "PlanEditScreen";

  @override
  _PlanEditScreenState createState() => _PlanEditScreenState();
}

class _PlanEditScreenState extends State<PlanEditScreen> {
  @override
  Widget build(BuildContext context) {
//    Map<String, dynamic> argu = ModalRoute.of(context).settings.arguments;

    PlanEditModel newModel = PlanEditModel(context);
//    newModel.setArgu(argu);

    return ChangeNotifierProvider<PlanEditModel>.value(
        value: newModel,
        child: Consumer<PlanEditModel>(
          builder: (context, model, child) => Scaffold(
            body: YunBasePage<PlanEditModel>.page(
              body: bodyWidget(model),
              model: model,
            ),
          ),
        ));
  }

  Widget bodyWidget(PlanEditModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('添加待办事项'),
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
//            _statusWidget(model),
            Expanded(child: _itemWidget(model)),
          ],
        ),
      ),
    );
  }

  void _saveOn(PlanEditModel model) {
    model.savePlan().then((suc) {
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
  Widget _itemWidget(PlanEditModel model) {
    PlanVo item = model.dto;

    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(_defPadding()),
//            color: Colors.black12,
            child: item.nameTf),
      ],
    );
  }

  double _defPadding() {
    return 10.0;
  }

// endregion

}
