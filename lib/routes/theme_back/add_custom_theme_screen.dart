import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_base/toast/yun_toast.dart';
import 'package:yun_record/models/theme_vo.dart';
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
        title: new Text("添加自定义主题"),
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
      body: new Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            itemCount: model.themeDto?.tagList?.length != null ? model.themeDto.tagList.length + 1 : 1,
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

  Widget _itemWidget(AddCustomThemeModel model, int index) {
    // 自定义主题
    if (index == 0) {
      return _headerWidget(model);
    }

    Tag value = model.themeDto.tagList[index - 1];

    return _itemTagWidget(value, index - 1);
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
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
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
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _addTagOn();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemTagWidget(Tag tag, int index) {
    List<Widget> items = List();

    Widget tagH = Container(
      color: Colors.grey[300],
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 10, top: 0, bottom: 0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 3,
              child: Form(
                key: tag.formKey,
                autovalidate: _autoValidate,
                child: tag.nameTf,
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addTagPropOn(tag, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    items.add(tagH);

    for (var prop in tag.propList) {
      Widget iH = Container(
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 30, right: 10, top: 0, bottom: 0),
              child: Flex(direction: Axis.horizontal, children: [
                Expanded(
                  child: Form(
                    key: prop.formKey,
                    autovalidate: _autoValidate,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 8,
                          child: prop.dataTypePopupMenu,
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 16,
                          child: prop.nameTf,
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 8,
                          child: prop.dataUnitTf,
                        )
                      ],
                    ),
                  ),
                ),
              ]),
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

  void _saveOn(AddCustomThemeModel model) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!model.valid()) {
      return;
    }

    model.saveTheme().then((suc) {
      if (suc) {
        YunToast.showToast("保存成功");
        Navigator.of(context).pop(1);
      }
    });
  }

  void _addTagOn() {
    model.themeDto.tagList.add(Tag.dto());
    model.notifyListeners();
  }

  void _addTagPropOn(Tag tag, int index) {
    model.themeDto.tagList[index].propList.add(Prop.dto());
    model.notifyListeners();
  }

// endregion

// region private

// endregion

}
