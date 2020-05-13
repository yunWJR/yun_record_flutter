import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_base/toast/yun_toast.dart';
import 'package:yun_record/routes/theme/add_custom_theme_model.dart';

class AddCustomThemeScreen extends StatefulWidget {
  static const routeName = "AddCustomThemeScreen";

  @override
  AddCustomThemeScreenState createState() => AddCustomThemeScreenState();
}

class AddCustomThemeScreenState extends State<AddCustomThemeScreen> {
  bool _autoValidate = false;

  AddCustomThemeModel model;

  @override
  Widget build(BuildContext context) {
    // 避免 model重置
    if (model == null) {
      model = AddCustomThemeModel(context);
    }

    return ChangeNotifierProvider<AddCustomThemeModel>.value(
        value: model,
        child: Consumer<AddCustomThemeModel>(
          builder: (context, model, child) => Scaffold(
            body: YunBasePage<AddCustomThemeModel>.page(
              body: _bodyWidget(model),
              model: model,
            ),
          ),
        ));
  }

  // region Widget

  Widget _bodyWidget(AddCustomThemeModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("添加主题"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: '保存主题',
            onPressed: () {
              _saveOn(model);
            },
          ),
        ],
      ),
      body: new Container(width: MediaQuery.of(context).size.width, child: _headerWidget(model)),
    );
  }

  Widget _headerWidget(AddCustomThemeModel model) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
//            color: Colors.grey[200],
          child: Form(
            key: model.themeDto.formKey,
            autovalidate: _autoValidate,
            child: model.themeDto.nameTf,
          ),
        ),
        const SizedBox(height: 10.0),
//        Container(
//          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
//          color: Theme.of(context).primaryColorLight,
//          child: Flex(
//            direction: Axis.horizontal,
//            children: [
//              Expanded(
//                flex: 3,
//                child: Row(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    Icon(Icons.table_chart),
//                    const SizedBox(width: 4.0),
//                    Text("记录项"),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
      ],
    );
  }

  // endregion

  // region Action

  void _saveOn(AddCustomThemeModel model) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!model.valid()) {
      return;
    }

    model.saveTheme().then((suc) {
      if (suc) {
        YunToast.showToast("保存成功", context);
        Navigator.of(context).pop(1);
      }
    });
  }

// endregion

// region private

// endregion

}
