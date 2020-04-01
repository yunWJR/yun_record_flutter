import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yun_record/routes/record/record_model.dart';
import 'package:yun_record/routes/record/theme/theme_list_screen.dart';

class RecordDrawerLeft extends StatefulWidget {
  RecordModel model;

  RecordDrawerLeft(RecordModel model, {Key key}) : super(key: key) {
    this.model = model;
  }

  @override
  _RecordDrawerLeftState createState() => _RecordDrawerLeftState(this.model);
}

class _RecordDrawerLeftState extends State<RecordDrawerLeft> {
  RecordModel model;

  _RecordDrawerLeftState(RecordModel model) {
    this.model = model;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return SizedBox(
      child: new Drawer(
//        elevation: 100,
        child: ListView(
//          padding: const EdgeInsets.only(),
          padding: EdgeInsets.zero.add(EdgeInsets.only(top: statusBarHeight)),
          children: _listWidgets(model),
        ),
      ),
    );
  }

  _listWidgets(RecordModel model) {
    List<Widget> widgets = List();

    widgets.add(Container(
      child: new ListTile(
        title: Row(
          children: <Widget>[
            new Text(
              '我的主题',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: Theme.of(context).textTheme.title.fontSize * 1.5),
            ),
            new IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pop(); /*隐藏drawer*/
                _gotoThemeMg(model);
              },
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    ));

    widgets.add(new Divider());
    widgets.add(Container(
      color: _colorBySel(null),
      child: new ListTile(
          title: new Text("全部主题"),
          trailing: _itemTrailing(null),
          onTap: () {
            _selThemeOn(model, null);
          }),
    ));

    for (var value in model.themeList) {
      widgets.add(new Divider());
      widgets.add(Container(
        color: _colorBySel(value.id),
        child: new ListTile(
            title: new Text(value.name),
            trailing: _itemTrailing(value.id),
            onTap: () {
              _selThemeOn(model, value.id);
            }),
      ));
    }

    return widgets;
  }

  _selThemeOn(RecordModel model, int themeId) {
    model.selectTheme(themeId);
    Navigator.of(context).pop(); /*隐藏drawer*/
  }

  Color _colorBySel(int themeId) {
    return model.isSelTheme(themeId) ? Theme.of(context).primaryColor : Colors.transparent;
  }

  Widget _itemTrailing(int themeId) {
    return model.isSelTheme(themeId) ? new Icon(Icons.check) : null;
  }

  void _gotoThemeMg(RecordModel model) async {
    var rst = await Navigator.pushNamed(context, ThemeListScreen.routeName, arguments: model);
//    if (rst != null) {
//      model.loadList(context);
//    }
  }
}
