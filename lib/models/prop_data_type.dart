//
// Created by yun on 2020/2/28.
//

// 1-Text、2-Int、3-Double、4-Money、5-Enum、6-Time、
import 'package:flutter/material.dart';
import 'package:yun_record/index.dart';

enum DataType { None, Text, Int, Double, Money, Enum, Time, Max }

class DataTypeItem {
  DataType type;
  String name;
  TextInputType inputType;

  DataTypeItem(this.type, this.name, this.inputType);
}

class DataTypeUtil {
  static List<DataTypeItem> _typeList = List.generate(DataType.Max.index, (int index) {
    DataType dType = DataType.values[index];

    DataTypeItem item;
    switch (dType) {
      case DataType.None:
        // TODO: Handle this case.
        break;
      case DataType.Text:
        item = DataTypeItem(dType, "文本", TextInputType.text);
        break;
      case DataType.Int:
        item = DataTypeItem(dType, "整数", TextInputType.numberWithOptions(signed: false, decimal: false));
        break;
      case DataType.Double:
        item = DataTypeItem(dType, "小数", TextInputType.numberWithOptions(signed: false, decimal: true));
        break;
      case DataType.Money:
        item = DataTypeItem(dType, "金钱", TextInputType.numberWithOptions(signed: false, decimal: true));
        break;
      case DataType.Enum:
        item = DataTypeItem(dType, "枚举", TextInputType.text);
        break;
      case DataType.Time:
        item = DataTypeItem(dType, "时间", TextInputType.text);
        break;
      case DataType.Max:
        // TODO: Handle this case.
        break;
    }

    return item;
  }).sublist(1);

  static DataTypeItem itemOfType(int type) {
    if (type == null) {
      return null;
    }

    if (type >= _typeList.length) {
      return null;
    }

    DataTypeItem item = _typeList[type];

    return item;
  }

  static String nameOfType(int type) {
    DataTypeItem item = itemOfType(type);

    if (item == null) {
      return "";
    }

    return item.name;
  }

  static TextInputType inputOfType(int type) {
    DataTypeItem item = itemOfType(type);

    if (item == null) {
      return TextInputType.text;
    }

    return item.inputType;
  }

  static List<PopupMenuItem> buttons() {
    List<PopupMenuItem> btns = List();

    for (int i = 0; i < _typeList.length; i++) {
      DataTypeItem v = _typeList[i];

      btns.add(PopupMenuItem(
        value: i,
        child: Text(v.name),
      ));
    }

    return btns;
  }
}
