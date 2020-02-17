import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yun_record/routes/homeTab/HomeTab.dart';

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
//          theme: model.requestTheme(Brightness.light),
//          darkTheme: model.requestTheme(Brightness.dark),
          home: GlobalConfig.isLogin ? HomeTab() : LoginScreen(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            "Login": (context) => LoginScreen(),
            "HomeTab": (context) => HomeTab(),
            "AddRecordScreen": (context) => AddRecordScreen(),
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
