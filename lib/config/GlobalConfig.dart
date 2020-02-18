import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yun_record/common/util/ValueUtils.dart';

import 'colors.dart';

enum Items { loginToken, userName, themeId }

enum Themes { light, dark, black, system }

class GlobalConfig {
  static bool saveSelf = true; // true：自己检查是否改变，自己保存到 Prefs
  static Map<int, String> _itemsKeyMap;
  static Map<int, bool> _itemsSaveMap;

  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  static SharedPreferences _prefs;

  // Light, dark & OLED themes
  static final List<ThemeData> themes = [
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

  static final List<ThemeData> systemThemes = [
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
  ];

  static ThemeData currentTheme(Brightness fallback) {
    if (theme == Themes.system) {
      return fallback == Brightness.dark ? systemThemes[1] : systemThemes[0];
    }

    return themeData;
  }

  // region field

  static String _loginToken;

  static String get loginToken => _loginToken;

  static set loginToken(String value) {
    if (!_saveSelf(Items.loginToken)) {
      _loginToken = value;
      return;
    }

    if (ValueUtils.isSame(_loginToken, value)) {
      return null;
    }

    _loginToken = value;

    savePref(Items.loginToken);
  }

  static bool get isLogin => ValueUtils.hasContent(_loginToken);

  static String _userName;

  static String get userName => _userName;

  static set userName(String value) {
    if (!_saveSelf(Items.userName)) {
      _userName = value;
      return;
    }

    if (ValueUtils.isSame(_userName, value)) {
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

    if (ValueUtils.isSameInt(_themeId, value)) {
      return null;
    }

    _themeId = value;

    savePref(Items.themeId);
  }

  // endregion

  static FlutterLocalNotificationsPlugin get notifications => _notifications;

  static Themes theme = Themes.dark;

  static ThemeData themeData = themes[1];

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
    _prefs = await SharedPreferences.getInstance();

    // Loads the theme
    try {
      theme = Themes.values[_prefs.getInt('theme')];
    } catch (e) {
      _prefs.setInt('theme', Themes.light.index);
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

    notifications.initialize(const InitializationSettings(
      AndroidInitializationSettings('notification_launch'),
      IOSInitializationSettings(),
    ));

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

  static void updateTheme(Themes themeId) {
    theme = themeId;
    themeData = themes[themeId.index];

    print('updateTheme');
    print(theme);
  }
}
