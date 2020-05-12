import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yun_base/alert/yun_alert.dart';
import 'package:yun_base/config/yun_config.dart';
import 'package:yun_base/http/yun_http.dart';
import 'package:yun_base/model/yun_page_base_noti_model.dart';
import 'package:yun_base/model/yun_rst_data.dart';
import 'package:yun_base/page/yun_base_page.dart';
import 'package:yun_base/util/yun_value.dart';
import 'package:yun_record/models/model_convert.dart';
import 'package:yun_record/models/user_vo.dart';
import 'package:yun_record/routes/login/login_screen.dart';

import '../index.dart';
import 'global_theme_config.dart';

enum Items { loginToken, userName, themeName, fontFactor }

class GlobalConfig {
  static bool saveSelf = true; // true：自己检查是否改变，自己保存到 Prefs
  static Map<int, String> _itemsKeyMap;
  static Map<int, bool> _itemsSaveMap;

  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  static SharedPreferences _prefs;

  static YunPageNavigatorOn nanOn;

  static UserVo userVo; // todo

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

  // endregion

  static FlutterLocalNotificationsPlugin get notifications => _notifications;

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
      case Items.themeName:
        // TODO: Handle this case.
        break;
      case Items.fontFactor:
        // TODO: Handle this case.
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
    YunConfig.isProp = true;
    YunConfig.logOnMode = YunOnMode.PROP_MODEL;

    YunBasePageConfig.defConfig.loadBgColor = Colors.transparent;

    ModelConvert.init();

    await _initItems();

    // noti
    notifications.initialize(const InitializationSettings(
      AndroidInitializationSettings('notification_launch'),
      IOSInitializationSettings(),
    ));

    // http config
    var rst = YunHttp.addHeader(HttpHeaders.authorizationHeader, _loginToken);
    YunHttp.baseUrl = "http://fffy.api.yunsoho.cn";
    if (YunConfig.isProp) {
      YunHttp.baseUrl = "http://fffy.api.yunsoho.cn";
    } else {
//      YunHttp.baseUrl = "http://192.168.0.118:11010";
      YunHttp.baseUrl = "http://127.0.0.1:11010";
//      YunHttp.baseUrl = "http://fffy.api.yunsoho.cn";
    }

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
            nanOn(LoginScreen.routeName, true);
          }
        }
      }
    };

    GlobalThemeConfig.initData();
  }

  static Future _initItems() async {
    _prefs = await SharedPreferences.getInstance();

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
    _itemsKeyMap[Items.themeName.index] = "themeName";
    _itemsKeyMap[Items.fontFactor.index] = "fontFactor";

//    // inti _itemsSaveMap
//    _itemsSaveMap = {};
//    _itemsSaveMap[Items.loginToken.index] = false;
  }

  static bool saveItem(Items item, String itemData, String user) {
    if (_prefs == null) {
      return false;
    }

    String key = _itemsKeyMap[item.index];
    if (key == null) {
      return false;
    }

    if (user != null) {
      key = user + ":" + key;
    }

    if (itemData == null) {
      _prefs.remove(key);
    } else {
      _prefs.setString(key, itemData);
    }

    return true;
  }

  static String getItem(Items item, String user) {
    if (_prefs == null) {
      return null;
    }

    String key = _itemsKeyMap[item.index];
    if (key == null) {
      return null;
    }

    if (user != null) {
      key = user + ":" + key;
    }

    return _prefs.getString(key);
  }

  static void setSaveSelf(Items item, bool saveSelf) {
    if (_itemsSaveMap == null) {
      _itemsSaveMap = {};
    }

    _itemsSaveMap[Items.loginToken.index] = saveSelf;
  }
}
