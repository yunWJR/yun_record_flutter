import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yun_record/routes/custom/edit/custom_edit_screen.dart';
import 'package:yun_record/routes/custom/list/custom_list_screen.dart';
import 'package:yun_record/routes/home_tab/home_tab.dart';
import 'package:yun_record/routes/login/register_screen.dart';
import 'package:yun_record/routes/my/settings_screen.dart';
import 'package:yun_record/routes/plan/edit/plan_edit_screen.dart';
import 'package:yun_record/routes/record/tag/add_tag_screen.dart';
import 'package:yun_record/routes/record/tag/theme_tag_list_screen.dart';
import 'package:yun_record/routes/theme/add_custom_theme_screen.dart';
import 'package:yun_record/routes/theme/add_temp_theme_screen.dart';
import 'package:yun_record/routes/theme/theme_list_screen.dart';
import 'package:yun_record/routes/theme/theme_temp_screen.dart';

import 'config/global_config.dart';
import 'config/global_config_noti.dart';
import 'model.dart';
import 'routes/login/login_screen.dart';
import 'routes/record/record/add_record_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalConfig.init().then((e) => runApp(MyApp()));

//  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeTab homeTab = HomeTab();
    LoginScreen loginScreen = LoginScreen();

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
          home: GlobalConfig.isLogin ? homeTab : loginScreen,
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            LoginScreen.routeName: (context) => loginScreen,
            RegisterScreen.routeName: (context) => RegisterScreen(),
            HomeTab.routeName: (context) => homeTab,
            AddRecordScreen.routeName: (context) => AddRecordScreen(),
            ThemeListScreen.routeName: (context) => ThemeListScreen(),
            PlanEditScreen.routeName: (context) => PlanEditScreen(),
            ThemeTempScreen.routeName: (context) => ThemeTempScreen(),
            AddTempThemeScreen.routeName: (context) => AddTempThemeScreen(),
            AddCustomThemeScreen.routeName: (context) => AddCustomThemeScreen(),
            SettingsScreen.routeName: (context) => SettingsScreen(),
            CustomEditScreen.routeName: (context) => CustomEditScreen(),
            CustomListScreen.routeName: (context) => CustomListScreen(),
            ThemeTagListScreen.routeName: (context) => ThemeTagListScreen(),
            AddTagScreen.routeName: (context) => AddTagScreen(),
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
