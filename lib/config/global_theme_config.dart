import 'package:flutter/material.dart';
import 'package:yun_record/index.dart';

import 'global_config.dart';

enum ThemeType {
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

class GlobalThemeConfig {
  // 主题列表
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
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      primaryColor: Colors.indigo,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
      primaryColor: Colors.orange,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
      primaryColor: Colors.pink,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.brown,
      primaryColor: Colors.brown,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.grey,
      primaryColor: Colors.grey,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
      primaryColor: Colors.red,
    ),
  ];

  // 自定义颜色主题
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

  // 系统主题
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

  // 字体大小配置
  static final List<num> fontSizeItems = [
    num.parse('0.5'),
    num.parse('0.8'),
    num.parse('1.0'),
    num.parse('1.2'),
    num.parse('1.4'),
    num.parse('1.6'),
    num.parse('1.8'),
    num.parse('2.0')
  ];

  static ThemeData currentTheme({Brightness brightness}) {
    ThemeData fT;

    if (themeType == ThemeType.system) {
      fT = (brightness == null || brightness == Brightness.light) ? _systemThemes[0] : _systemThemes[1];
    } else {
      fT = themeData;
    }

    return fT.copyWith(textTheme: GlobalThemeConfig.newTextTheme(fT.textTheme, fontFactor.toDouble()));
  }

  static ThemeData themeOfIndex(ThemeType theme) {
    ThemeData fT;

    if (theme == ThemeType.system) {
      fT = _systemThemes[0];
    } else {
      // 除去第一个系统主题
      fT = _themes[theme.index - 1];
    }

    return fT.copyWith(textTheme: GlobalThemeConfig.newTextTheme(fT.textTheme, fontFactor.toDouble()));
  }

  static void updateTheme(ThemeType type) {
    if (themeType == type) {
      return;
    }

    themeType = type;

    if (themeType != ThemeType.system) {
      themeData = _themes[themeType.index - 1];
    }

    String item = themeType.toString();

    GlobalConfig.saveItem(Items.themeName, item, userId());
  }

  static TextTheme newTextTheme(TextTheme txtTm, double fontSizeFactor) {
    TextTheme newItem = TextTheme(
      display4: txtTm.display4.copyWith(fontSize: 14),
      display3: txtTm.display3.copyWith(fontSize: 14),
      display2: txtTm.display2.copyWith(fontSize: 14),
      display1: txtTm.display1.copyWith(fontSize: 14),
      headline: txtTm.headline.copyWith(fontSize: 14),
      title: txtTm.title.copyWith(fontSize: 14),
      subhead: txtTm.subhead.copyWith(fontSize: 14),
      body2: txtTm.body2.copyWith(fontSize: 14),
      body1: txtTm.body1.copyWith(fontSize: 14),
      caption: txtTm.caption.copyWith(fontSize: 14),
      button: txtTm.button.copyWith(fontSize: 14),
      subtitle: txtTm.subtitle.copyWith(fontSize: 14),
      overline: txtTm.overline.copyWith(fontSize: 14),
    );

    newItem = newItem.apply(fontSizeFactor: fontSizeFactor);

    return newItem;
  }

  // region field

  static num _fontFactor = num.parse('1.0');

  static num get fontFactor => _fontFactor;

  static set fontFactor(num value) {
    if (_fontFactor == value) {
      return;
    }

    _fontFactor = value;

    GlobalConfig.saveItem(Items.fontFactor, _fontFactor.toString(), userId());
  }

  static ThemeType themeType = ThemeType.system;

  static ThemeData themeData = _themes[0];

  static void initData() {
    // 加载主题
    String themeName = GlobalConfig.getItem(Items.themeName, userId());
    if (themeName != null) {
      for (var value in ThemeType.values) {
        if (value.toString() == themeName) {
          if (themeType != value) {
            updateTheme(value);
          }
          break;
        }
      }
    }

    // 加载主题
    String fontF = GlobalConfig.getItem(Items.fontFactor, userId());
    if (fontF != null) {
      num fN = num.tryParse(fontF);
      if (fN != null) {
        for (var value in fontSizeItems) {
          if (value == fN) {
            if (fontFactor != value) {
              fontFactor = value;
            }
            break;
          }
        }
      }
    }
  }

  static String userId() {
    return null;
  }
}

/// LIGHT THEME
const lightPrimaryColor = Color(0xFF1E1E1E);
const lightAccentColor = Color(0xFF3949AB);

/// DARK THEME
const darkPrimaryColor = Color(0xFF151515);
const darkAccentColor = Color(0xFFFBC02D);
const darkBackgroundColor = Color(0xFF212121);
const darkCanvasColor = Color(0xFF272727);
const darkCardColor = Color(0xFF2C2C2C);
const darkDividerColor = Color(0xFF424242);

/// BLACK THEME
const blackPrimaryColor = Color(0xFF000000);
const blackAccentColor = Color(0xFFFFFFFF);
const blackBackgroundColor = Color(0xFF000000);
const blackCardColor = Color(0xFF000000);
const blackDividerColor = Color(0xFF323232);
