//
// Created by yun on 2020-02-18.
//

import 'dart:io';

/// 主题模式：0-根据系统判断；1-全部 iOS；2-全部 Material
enum ThemeMode { AUTO, IOS, MATERIAL }

class YunConfig {
  static ThemeMode themeMode = ThemeMode.IOS;

  /// 使用 iOS 模式
  static bool iOSMode() {
    if (themeMode == ThemeMode.AUTO) {
      return Platform.isIOS;
    }

    return themeMode == ThemeMode.IOS;
  }

  /// 使用 MATERIAL 模式
  static bool materialMode() {
    if (themeMode == ThemeMode.AUTO) {
      return Platform.isAndroid;
    }

    return themeMode == ThemeMode.MATERIAL;
  }
}
