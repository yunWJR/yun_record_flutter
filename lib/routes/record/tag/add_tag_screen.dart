import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_record/models/TagVo.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/widgets/select_theme.dart';

import 'add_tag_model.dart';

class AddTagScreen extends StatefulWidget {
  static const routeName = "AddTagScreen";

  @override
  AddTagScreenState createState() => AddTagScreenState();
}

class AddTagScreenState extends State<AddTagScreen> {
  bool _autoValidate = false;

  AddTagModel model;

  @override
  Widget build(BuildContext context) {
    List<ThemeVo> themeList = ModalRoute.of(context).settings.arguments;

    // 避免 model重置
    if (model == null) {
      model = AddTagModel(context, themeList);
    }

    return ChangeNotifierProvider<AddTagModel>.value(
        value: model,
        child: Consumer<AddTagModel>(
          builder: (context, model, child) => Scaffold(
            body: YunBasePage<AddTagModel>.page(
              body: _bodyWidget(model),
              model: model,
            ),
          ),
        ));
  }

  // region Widget

  Widget _bodyWidget(AddTagModel model) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("添加记录"),
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
          child: ListView.separated(
            itemCount: model.tagDto?.propList?.length != null ? model.tagDto.propList.length + 1 : 1,
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

  Widget _itemWidget(AddTagModel model, int index) {
    // tag
    if (index == 0) {
      return _headerWidget(model);
    }

    TagPropVo propVo = model.tagDto.propList[index - 1];

    return _itemTagWidget(propVo, index - 1);
  }

  Widget _headerWidget(AddTagModel model) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
//            color: Colors.grey[200],
          child: SelectTheme(
            key: model.tagDto.themeKey,
            selIndex: 0,
            changed: (index, item) {
              model.tagDto.themeId = item.id;
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10),
//            color: Colors.grey[200],
          child: Form(
            key: model.tagDto.formKey,
            autovalidate: _autoValidate,
            child: model.tagDto.nameTf,
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

  Widget _itemTagWidget(TagPropVo tag, int index) {
    var prop = tag;

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

    return iH;
  }

  // endregion

  // region Action

  void _saveOn(AddTagModel model) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!model.valid()) {
      return;
    }

    model.saveTag().then((suc) {
      if (suc) {
        Toast.show("保存成功", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Navigator.of(context).pop(1);
      }
    });
  }

  void _addTagOn() {
    model.tagDto.propList.add(TagPropVo.dto());
    model.notifyListeners();
  }

// endregion

// region private

// endregion

}
