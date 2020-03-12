//
// Created by yun on 2020/2/28.
//

// 1-Text、2-Int、3-Double、4-Money、5-Enum、6-Time、
enum DataType { None, Text, Int, Double, Money, Enum, Time }

class DataTypeUtil {
  static List<Map<int, String>> _typeList;

  static List<Map<int, String>> get typeList {
    if (_typeList == null) {
      _addType(DataType.Text, "文本");
      _addType(DataType.Int, "整数");
      _addType(DataType.Double, "小数");
    }
    return _typeList;
  }

  static void _addType(DataType type, String name) {
    if (_typeList == null) {
      _typeList = List<Map<int, String>>();
    }

    Map<int, String> map = Map();
    map[type.index] = "文本";

    _typeList.add(map);
  }
}
