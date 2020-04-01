import 'package:flutter/material.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/config/global_theme_config.dart';
import 'package:yun_record/index.dart';

import 'global_config.dart';

abstract class GlobalConfigNoti extends ChangeNotifier {
  Items item;

  @override
  void notifyListeners() {
    GlobalConfig.savePref(item); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class LoginTokenGcn extends GlobalConfigNoti {
  LoginTokenGcn() : super() {
//    GlobalConfig.setSaveSelf(item, false); todo
  }

  Items item = Items.loginToken;

  bool get isLogin => YunValue.hasContent(GlobalConfig.loginToken);

  String get loginToken => GlobalConfig.loginToken;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set loginToken(String loginToken) {
    if (YunValue.isSame(loginToken, GlobalConfig.loginToken)) {
      return null;
    }

    GlobalConfig.loginToken = loginToken;

    notifyListeners();
  }
}

class ThemeGcn extends GlobalConfigNoti {
  ThemeGcn() : super() {
    GlobalConfig.setSaveSelf(item, false);
  }

  ThemeData currentTheme({Brightness brightness}) {
    return GlobalThemeConfig.currentTheme(brightness: brightness);
  }

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  setThemeIndex(ThemeType theme) {
    if (theme == GlobalThemeConfig.themeType) {
      return null;
    }

    GlobalThemeConfig.updateTheme(theme);

    notifyListeners();
  }

  setFontFactor(num fFactor) {
    if (fFactor == GlobalThemeConfig.fontFactor) {
      return null;
    }

    GlobalThemeConfig.fontFactor = fFactor;

    notifyListeners();
  }
}
