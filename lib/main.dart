import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_record/routes/homeTab/HomeTab.dart';
import 'package:yun_record/routes/my/SettingsScreen.dart';

import 'config/GlobalConfig.dart';
import 'config/GlobalConfigNoti.dart';
import 'routes/login/LoginScreen.dart';
import 'routes/record/AddRecordScreen.dart';

final ThemeGcn themeGcn = ThemeGcn();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalConfig.init().then((e) => runApp(MyApp()));

//  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeGcn>(
      create: (context) => themeGcn,
      child: Consumer<ThemeGcn>(
        builder: (context, model, child) => MaterialApp(
          title: 'YUN RECORD',
          theme: themeGcn.themeData,
          darkTheme: themeGcn.themeData,
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
