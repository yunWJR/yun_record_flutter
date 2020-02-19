import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yun_base/alert/yun_alert.dart';
import 'package:yun_base/http/yun_http.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/model/yun_rst_data.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/config/theme_config.dart';
import 'package:yun_record/models/user_vo.dart';

import 'colors.dart';

enum Items { loginToken, userName, themeId }

enum Themes {
  system,
  amber,
  cyan,
  teal,
  green,
  purple,
  indigo,
  orange,
  pink,
  brown,
  grey,
  red,
}

class GlobalConfig {
  static bool saveSelf = true; // true：自己检查是否改变，自己保存到 Prefs
  static Map<int, String> _itemsKeyMap;
  static Map<int, bool> _itemsSaveMap;

  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  static SharedPreferences _prefs;

  static YunPageNavigatorOn nanOn;

  static UserVo userVo; // todo

  static final List<ThemeData> _themes = [
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.amber,
      primaryColor: Colors.amber,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.cyan,
      primaryColor: Colors.cyan,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.teal,
      primaryColor: Colors.teal,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      primaryColor: Colors.green,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.deepPurple,
      textTheme: TextTheme(),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      primaryColor: Colors.indigo,
      textTheme: TextTheme(),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
      primaryColor: Colors.orange,
      textTheme: TextTheme(),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
      primaryColor: Colors.pink,
      textTheme: TextTheme(),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.brown,
      primaryColor: Colors.brown,
      textTheme: TextTheme(),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.grey,
      primaryColor: Colors.grey,
      textTheme: TextTheme(),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
      primaryColor: Colors.red,
      textTheme: TextTheme(),
    ),
  ];

  static final List<ThemeData> _themesBack = [
    ThemeData(
      brightness: Brightness.light,
      primaryColor: lightPrimaryColor,
      accentColor: lightAccentColor,
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      accentColor: darkAccentColor,
      canvasColor: darkCanvasColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      cardColor: darkCardColor,
      dividerColor: darkDividerColor,
      dialogBackgroundColor: darkCardColor,
      popupMenuTheme: PopupMenuThemeData(
        color: darkCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    ThemeData(
      brightness: Brightness.dark,
      primaryColor: blackPrimaryColor,
      accentColor: blackAccentColor,
      canvasColor: blackBackgroundColor,
      scaffoldBackgroundColor: blackBackgroundColor,
      cardColor: blackCardColor,
      dividerColor: blackDividerColor,
      dialogBackgroundColor: darkCardColor,
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: blackDividerColor),
        ),
      ),
    )
  ];

  static final List<ThemeData> _systemThemes = [
    ThemeData(
      brightness: Brightness.light,
      //      primaryColor: lightPrimaryColor,
      //      accentColor: lightAccentColor,
      //      popupMenuTheme: PopupMenuThemeData(
      //        shape: RoundedRectangleBorder(
      //          borderRadius: BorderRadius.circular(6),
      //        ),
      //      ),
    ),
    ThemeData(
      brightness: Brightness.dark,
      //      primaryColor: darkPrimaryColor,
      //      accentColor: darkAccentColor,
      //      canvasColor: darkCanvasColor,
      //      scaffoldBackgroundColor: darkBackgroundColor,
      //      cardColor: darkCardColor,
      //      dividerColor: darkDividerColor,
      //      dialogBackgroundColor: darkCardColor,
      //      popupMenuTheme: PopupMenuThemeData(
      //        color: darkCardColor,
      //        shape: RoundedRectangleBorder(
      //          borderRadius: BorderRadius.circular(6),
      //        ),
      //      ),
    ),
  ];

  static ThemeData currentTheme({Brightness brightness}) {
    ThemeData fT;

    if (theme == Themes.system) {
      fT = (brightness == null || brightness == Brightness.light) ? _systemThemes[0] : _systemThemes[1];
    } else {
      fT = themeData;
    }

    double ff = ThemeConfig.fontSizeItems[_fontSizeIndex];

    return fT.copyWith(textTheme: ThemeConfig.newTextTheme(fT.textTheme, ff));
  }

  static ThemeData themeOfIndex(Themes theme) {
    ThemeData fT;

    if (theme == Themes.system) {
      fT = _systemThemes[0];
    } else {
      fT = _themes[theme.index - 1];
    }

    return fT.copyWith(textTheme: ThemeConfig.newTextTheme(fT.textTheme, fontFactor()));
  }

  static double fontFactor() {
    double ff = ThemeConfig.fontSizeItems[_fontSizeIndex];

    return ff;
  }

  static void updateTheme(Themes themeId) {
    theme = themeId;

    if (theme != Themes.system) {
      themeData = _themes[theme.index - 1];
    }
  }

  // region field

  static String _loginToken;

  static String get loginToken => _loginToken;

  static set loginToken(String value) {
    if (!_saveSelf(Items.loginToken)) {
      // 更新 token
      _loginToken = value;
      YunHttp.addHeader(HttpHeaders.authorizationHeader, _loginToken);
      return;
    }

    if (YunValue.isSame(_loginToken, value)) {
      return null;
    }

    // 更新 token
    _loginToken = value;
    YunHttp.addHeader(HttpHeaders.authorizationHeader, _loginToken);

    savePref(Items.loginToken);
  }

  static bool get isLogin => YunValue.hasContent(_loginToken);

  static String _userName;

  static String get userName => _userName;

  static set userName(String value) {
    if (!_saveSelf(Items.userName)) {
      _userName = value;
      return;
    }

    if (YunValue.isSame(_userName, value)) {
      return null;
    }

    _userName = value;

    savePref(Items.userName);
  }

  static int _themeId;

  static int get themeId => _themeId;

  static set themeId(int value) {
    if (!_saveSelf(Items.themeId)) {
      _themeId = value;
      return;
    }

    if (YunValue.isSameInt(_themeId, value)) {
      return null;
    }

    _themeId = value;

    savePref(Items.themeId);
  }

  static int _fontSizeIndex = 2;

  static int get fontSizeIndex => _fontSizeIndex;

  static set fontSizeIndex(int value) {
    if (_fontSizeIndex == value) {
      return null;
    }

    _fontSizeIndex = value;
  }

  // endregion

  static FlutterLocalNotificationsPlugin get notifications => _notifications;

  static Themes theme = Themes.cyan;

  static ThemeData themeData = _themes[0];

  static savePref(Items item) {
    if (_prefs == null || item == null) {
      return;
    }

    String key = _itemsKeyMap[item.index];

    switch (item) {
      case Items.loginToken:
        _loginToken == null ? _prefs.remove(key) : _prefs.setString(key, _loginToken);
        break;
      case Items.userName:
        _userName == null ? _prefs.remove(key) : _prefs.setString(key, _userName);
        break;
      case Items.themeId:
        _themeId == null ? _prefs.remove(key) : _prefs.setInt(key, _themeId);
        break;
    }
  }

  static bool _saveSelf(Items item) {
    String key = _itemsKeyMap[item.index];

    bool save = _itemsSaveMap[key];
    if (save == null) {
      return saveSelf;
    }

    return save;
  }

  static Future init() async {
    await _initItems();

    // noti
    notifications.initialize(const InitializationSettings(
      AndroidInitializationSettings('notification_launch'),
      IOSInitializationSettings(),
    ));

    // http config
    var rst = YunHttp.addHeader(HttpHeaders.authorizationHeader, _loginToken);
    YunHttp.baseUrl = "http://fffy.api.yunsoho.cn";

    // err config
    YunAlert.rspErrHandle = (dynamic org, YunRspData data) {
      if (data.type == YunRspDataType.HTTP) {
        // 登录失效
        if (data.code == 401) {
          loginToken = null;

          if (org is YunPageBaseNotiModel) {
            if (org.nagOn != null) {
              org.nagOn("Login", true);

              return;
            }
          }

          if (nanOn != null) {
            nanOn("Login", true);
          }
        }
      }
    };
  }

  static Future _initItems() async {
    _prefs = await SharedPreferences.getInstance();

    // Loads the theme
    try {
      theme = Themes.values[_prefs.getInt('theme')];
    } catch (e) {
      _prefs.setInt('theme', Themes.amber.index);
    }

    // Loads loginToken
    try {
      _loginToken = _prefs.getString('loginToken');
    } catch (e) {
      _prefs.remove('loginToken');
    }

    // Loads userName
    try {
      _userName = _prefs.getString('userName');
    } catch (e) {
      _prefs.remove('userName');
    }

    // inti itemsKeyMap
    _itemsKeyMap = {};
    _itemsKeyMap[Items.loginToken.index] = "loginToken";
    _itemsKeyMap[Items.userName.index] = "userName";
    _itemsKeyMap[Items.themeId.index] = "themeId";

//    // inti _itemsSaveMap
//    _itemsSaveMap = {};
//    _itemsSaveMap[Items.loginToken.index] = false;
  }

  static void setSaveSelf(Items item, bool saveSelf) {
    if (_itemsSaveMap == null) {
      _itemsSaveMap = {};
    }

    _itemsSaveMap[Items.loginToken.index] = saveSelf;
  }
}
