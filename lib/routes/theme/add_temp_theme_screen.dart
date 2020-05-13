import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_base/toast/yun_toast.dart';
import 'package:yun_record/models/prop_data_type.dart';
import 'package:yun_record/models/theme_temp_vo.dart';

import 'add_theme_model.dart';

class AddTempThemeScreen extends StatefulWidget {
  static const routeName = "AddTempThemeScreen";

  @override
  AddTempThemeScreenState createState() => AddTempThemeScreenState();
}

class AddTempThemeScreenState extends State<AddTempThemeScreen> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    ThemeTempVo tmpVo = ModalRoute.of(context).settings.arguments;

    String title = tmpVo?.id == null ? "添加自定义主题" : "添加模板主题";

    if (tmpVo?.name != null) {
      _nameController.text = tmpVo.name;
    }

    AddTempThemeModel newModel = AddTempThemeModel(context, tmpVo);
//    newModel.setArgu(argu);

    return ChangeNotifierProvider<AddTempThemeModel>.value(
        value: newModel,
        child: Consumer<AddTempThemeModel>(
          builder: (context, model, child) => Scaffold(
            body: YunBasePage<AddTempThemeModel>.page(
              body: _bodyWidget(model, title),
              model: model,
            ),
          ),
        ));
  }

  // region Widget

  Widget _bodyWidget(AddTempThemeModel model, String title) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(title),
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
//          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            itemCount: model.tmpVo?.tagList?.length != null ? model.tmpVo?.tagList?.length + 1 : 1,
//                    itemExtent: 50.0, //强制高度为50.0
            itemBuilder: (BuildContext context, int index) {
              return _itemWidget(model, index);
            },
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
//                color: Theme.of(context).primaryColor,
                height: 4,
                thickness: 0,
              );
            },
          )),
    );
  }

  Widget _itemWidget(AddTempThemeModel model, int index) {
    // 自定义主题
    if (index == 0) {
      return _headerWidget(model);
    }

    Tag value = model.tmpVo.tagList[index - 1];

    return _itemTagWidget(value);
  }

  Widget _headerWidget(AddTempThemeModel model) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
//            color: Colors.grey[200],
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: new TextFormField(
                controller: _nameController,
                validator: _validateUserName,
                keyboardType: TextInputType.text,
                decoration:
                    InputDecoration(labelText: "主题名称*", hintText: "请输入主题名称", labelStyle: new TextStyle(fontSize: 13))),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          color: Theme.of(context).primaryColorLight,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.table_chart),
                    const SizedBox(width: 4.0),
                    Text("记录项"),
                  ],
                ),
              ),
//              Expanded(
//                flex: 1,
//                child: Align(
//                  alignment: Alignment.centerRight,
//                  child: IconButton(
//                    icon: Icon(Icons.add),
//                    onPressed: () {
//                      _addTagOn();
//                    },
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemTagWidget(Tag value) {
    List<Widget> items = List();

    Widget tH = Container(
      color: Colors.grey[300],
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.title),
                  const SizedBox(width: 4.0),
                  Text(value.name),
                ],
              ),
            ),
//            Expanded(
//              flex: 1,
//              child: Align(
//                alignment: Alignment.centerRight,
//                child: IconButton(
//                  icon: Icon(Icons.add),
//                  onPressed: () {
//                    _addTagOn();
//                  },
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );

    items.add(tH);

    for (var prop in value.propList) {
      Widget iH = Container(
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 30, right: 10, top: 5, bottom: 5),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
//                    Icon(Icons.title),
//                    const SizedBox(width: 4.0),
                        Text('标题：${prop.name}'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
//                    Icon(Icons.title),
//                    const SizedBox(width: 4.0),
                        Text('类型：${DataTypeUtil.nameOfType(prop.dataType)}'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
//                    Icon(Icons.title),
//                    const SizedBox(width: 4.0),
                        Text('单位：${prop.dataUnitName()}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[400],
            )
          ],
        ),
      );

      items.add(iH);
    }

    return Column(
      children: items,
    );
  }

  String _validateUserName(String uName) {
    if (uName.length == null || uName.length == 0) {
      return '请输入主题名称';
    }

    return null;
  }

  // endregion

  // region Action

  void _saveOn(AddTempThemeModel model) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!_formKey.currentState.validate()) {
      return;
    }

    model.createThemeByTemplate(model.tmpVo.id, _nameController.text).then((suc) {
      if (suc) {
        YunToast.showToast("主题创建成功", context);
//        Navigator.pushReplacementNamed(context, "HomeTab"); // todo
        Navigator.pop(context, true);
      }
    });
  }

// endregion

// region private

// endregion

}
