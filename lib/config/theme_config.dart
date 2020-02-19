//
// Created by yun on 2020-02-19.
//

import 'package:flutter/material.dart';

class ThemeConfig {
  static final List<double> fontSizeItems = [0.5, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0];

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
}
