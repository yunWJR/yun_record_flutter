import 'package:flutter/material.dart';
import 'package:yun_record/common/util/ValueUtils.dart';

import 'GlobalConfig.dart';

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

  bool get isLogin => ValueUtils.hasContent(GlobalConfig.loginToken);

  String get loginToken => GlobalConfig.loginToken;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set loginToken(String loginToken) {
    if (ValueUtils.isSame(loginToken, GlobalConfig.loginToken)) {
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

  Items item = Items.themeId;

  Themes get theme => GlobalConfig.theme;

  ThemeData get themeData => GlobalConfig.themeData;

  ThemeData currentTheme(Brightness brightness) {
    return GlobalConfig.currentTheme(brightness);
  }

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  setThemeIndex(Themes theme) {
    if (theme == GlobalConfig.theme) {
      return null;
    }

    GlobalConfig.updateTheme(theme);

    notifyListeners();
  }
}
