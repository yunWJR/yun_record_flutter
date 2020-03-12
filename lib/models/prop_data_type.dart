//
// Created by yun on 2020/2/28.
//

// 1-Text、2-Int、3-Double、4-Money、5-Enum、6-Time、
import 'package:flutter/material.dart';

enum DataType { None, Text, Int, Double, Money, Enum, Time }

class DataTypeItem {
  int type;
  String name;

  DataTypeItem(DataType type, String name) {
    this.type = type.index;
    this.name = name;
  }
}

class DataTypeUtil {
  static List<DataTypeItem> _typeList;
  static Map<int, String> _typeMap;

  static List<DataTypeItem> get typeList {
    if (_typeList == null) {
      _addType(DataType.Text, "文本");
      _addType(DataType.Int, "整数");
      _addType(DataType.Double, "小数");
    }
    return _typeList;
  }

  static void _addType(DataType type, String name) {
    if (_typeList == null) {
      _typeList = List<DataTypeItem>();
    }

    if (_typeMap == null) {
      _typeMap = Map();
    }
    _typeMap[type.index] = name;

    DataTypeItem item = DataTypeItem(type, name);
    _typeList.add(item);
  }

  static String nameOfType(int type) {
    if (type == null) {
      return "";
    }

    String name = _typeMap[type];

    if (name == null) {
      return "";
    }

    return name;
  }

  static List<PopupMenuItem> buttons() {
    List<PopupMenuItem> btns = List();

    for (DataTypeItem v in typeList) {
      btns.add(PopupMenuItem(
        value: v.type,
        child: Text(v.name),
      ));
    }

    return btns;
  }
}
