import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_record/routes/homeTab/HomeTab.dart';

import 'config/GlobalConfig.dart';
import 'config/GlobalConfigNoti.dart';
import 'routes/login/LoginScreen.dart';

final ThemeGcn themeGcn = ThemeGcn();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalConfig.init().then((e) => runApp(MyApp()));

//  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeGcn>(
      create: (context) => themeGcn,
      child: Consumer<ThemeGcn>(
        builder: (context, model, child) => MaterialApp(
          title: 'YUN RECORD',
//          theme: model.requestTheme(Brightness.light),
//          darkTheme: model.requestTheme(Brightness.dark),
          home: GlobalConfig.isLogin ? HomeTab() : LoginScreen(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            "login": (context) => LoginScreen(),
            "homeTab": (context) => HomeTab(),
          },
//          localizationsDelegates: [
//            FlutterI18nDelegate(fallbackFile: 'en'),
//            GlobalMaterialLocalizations.delegate,
//            GlobalWidgetsLocalizations.delegate
//          ],
        ),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeGcn>(
          create: (context) => ThemeGcn(),
//            lazy: false,
          child: Consumer<ThemeGcn>(
            builder: (context, model, child) => MaterialApp(
//              theme: ThemeData(
//                primarySwatch: themeModel.theme,
//              ),
              onGenerateTitle: (context) {
                return "yun record";
              },
              home: GlobalConfig.isLogin ? LoginScreen() : LoginScreen(),
              // 注册路由表
              routes: <String, WidgetBuilder>{
                "login": (context) => LoginScreen(),
                "homeTab": (context) => HomeTab(),
              },
            ),
          ),
        ),
      ],
    );
  }
}
