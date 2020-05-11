import 'package:flutter/material.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/theme_vo.dart';
import 'package:yun_record/widgets/select_theme_model.dart';

typedef void SelectedThemeChanged(int index, ThemeVo item);

class SelectTheme extends StatefulWidget {
  SelectTheme({Key key, int selIndex, SelectedThemeChanged changed}) : super(key: key) {
    this._selIndex = selIndex;
    this._changed = changed;
  }

  int _selIndex;
  ThemeVo _selItem;
  SelectedThemeChanged _changed;

  int get typeValue => _selIndex;

  ThemeVo get selItem => _selItem;

  @override
  State<StatefulWidget> createState() {
    return SelectThemeState(_selIndex, (int index, ThemeVo item) {
      if (index != _selIndex) {
        this._selIndex = index;
        this._selItem = item;
        if (_changed != null) {
          _changed(index, item);
        }
      }
    });
  }
}

class SelectThemeState extends State<SelectTheme> {
  int _index;
  SelectedThemeChanged _changed;

  SelectThemeModel model;

  SelectThemeState(this._index, this._changed);

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      model = SelectThemeModel(context, _index);
    }

    return ChangeNotifierProvider<SelectThemeModel>.value(
        value: model,
        child: Consumer<SelectThemeModel>(
          builder: (context, model, child) => bodyWidget(model),
        ));
  }

  bodyWidget(SelectThemeModel model) {
    return FlatButton(
      child: Row(
        children: [Text(model.selName()), Icon(Icons.expand_more)],
      ),
      onPressed: () => _changeTheme(model),
    );
  }

  void onChanged(int type) {
    setState(() {
      _index = type;
    });
  }

  _changeTheme(SelectThemeModel model) async {
    if (!model.hasTheme()) {
      YunAlert.showErr(context, "无主题");
      return;
    }

    int index = await YunAction.showAction(context, model.themeList.map((f) => f.name).toList(), title: "请选择主题");

    if (index != null && index != model.selIndex) {
      model.updateIndex(index);
      _index = index;

      if (_changed != null) {
        _changed(model.selIndex, model.themeList[_index]);
      }
    }
  }
}
