import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yun_record/routes/home_tab/home_tab.dart';
import 'package:yun_record/routes/my/settings_screen.dart';

import 'config/global_config.dart';
import 'config/global_config_noti.dart';
import 'model.dart';
import 'routes/login/login_screen.dart';
import 'routes/record/add_record_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalConfig.init().then((e) => runApp(MyApp()));

//  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<ThemeGcn>.value(value: themeGcn),
        ChangeNotifierProvider<LoginTokenGcn>.value(value: loginTokenGcn),
      ],
      child: Consumer2<ThemeGcn, LoginTokenGcn>(
        builder: (BuildContext context, themeGcn, loginTokenGcn, Widget child) => MaterialApp(
          title: 'YUN 随记',
          theme: themeGcn.currentTheme(brightness: Brightness.light),
          darkTheme: themeGcn.currentTheme(brightness: Brightness.dark),
          home: GlobalConfig.isLogin ? HomeTab() : LoginScreen(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            "Login": (context) => LoginScreen(),
            "HomeTab": (context) => HomeTab(),
            "AddRecordScreen": (context) => AddRecordScreen(),
            "SettingsScreen": (context) => SettingsScreen(),
          },
          //          localizationsDelegates: [
          //            FlutterI18nDelegate(fallbackFile: 'en'),
          //            GlobalMaterialLocalizations.delegate,
          //            GlobalWidgetsLocalizations.delegate
          //          ],
        ),
      ),
    );

    return ChangeNotifierProvider<ThemeGcn>(
      create: (context) => themeGcn,
      child: Consumer<ThemeGcn>(
        builder: (context, model, child) => MaterialApp(
          title: 'YUN 随记',
          theme: themeGcn.currentTheme(brightness: Brightness.light),
          darkTheme: themeGcn.currentTheme(brightness: Brightness.dark),
          home: GlobalConfig.isLogin ? HomeTab() : LoginScreen(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            "Login": (context) => LoginScreen(),
            "HomeTab": (context) => HomeTab(),
            "AddRecordScreen": (context) => AddRecordScreen(),
            "SettingsScreen": (context) => SettingsScreen(),
          },
          //          localizationsDelegates: [
          //            FlutterI18nDelegate(fallbackFile: 'en'),
          //            GlobalMaterialLocalizations.delegate,
          //            GlobalWidgetsLocalizations.delegate
          //          ],
        ),
      ),
    );
  }
}
