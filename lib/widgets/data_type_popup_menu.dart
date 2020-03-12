import 'package:flutter/material.dart';
import 'package:yun_record/index.dart';
import 'package:yun_record/models/prop_data_type.dart';

typedef void TypeChanged(int type);

class DataTypePopupMenu extends StatefulWidget {
  DataTypePopupMenu({Key key, int typeValue, TypeChanged typeChanged})
      : super(key: key) {
    this._typeValue = typeValue;
    this._typeChanged = typeChanged;
  }

  int _typeValue;
  TypeChanged _typeChanged;

  int get typeValue => _typeValue;

  @override
  State<StatefulWidget> createState() {
    return DataTypePopupMenuState(_typeValue, (int type) {
      this._typeValue = type;
      if (_typeChanged != null) {
        _typeChanged(type);
      }
    });
  }
}

class DataTypePopupMenuState extends State<DataTypePopupMenu> {
  int _index = null;
  TypeChanged _typeChanged;

  DataTypePopupMenuState(this._index, this._typeChanged);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(DataTypeUtil.nameOfType(_index)),
        PopupMenuButton(
          icon: Icon(Icons.filter_list),
          onSelected: (value) {
            setState(() {
              _index = value;
            });

            if (_typeChanged != null) {
              _typeChanged(_index);
            }
          },
          itemBuilder: (BuildContext context) => DataTypeUtil.buttons(),
        ),
      ],
    );
  }

  void onChanged(int type) {
    setState(() {
      _index = type;
    });
  }
}
