import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yun_record/routes/custom/custom_home_screen.dart';
import 'package:yun_record/routes/custom/custom_model.dart';
import 'package:yun_record/routes/my/my_model.dart';
import 'package:yun_record/routes/my/my_screen.dart';
import 'package:yun_record/routes/plan/plan_home_screen.dart';
import 'package:yun_record/routes/plan/plan_model.dart';
import 'package:yun_record/routes/record/record_home_screen.dart';
import 'package:yun_record/routes/record/record_model.dart';

class HomeTab extends StatefulWidget {
  static const routeName = "HomeTab";

  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;

  List<SingleChildWidget> _models;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_models == null) {
      RecordModel m = RecordModel(context);
      _models = [
        ChangeNotifierProvider.value(
          value: m,
          child: RecordHomeScreen(),
        ),
//        ChangeNotifierProvider.value(
//          value: m,
//          child: ThemeScreen(),
//        ),

//        ChangeNotifierProvider<RecordModel>(
//          create: (context) => RecordModel(context),
//          child: RecordScreen(),
//        ),
        ChangeNotifierProvider<CustomModel>(
          create: (context) => CustomModel(context),
          child: CustomHomeScreen(),
        ),
        ChangeNotifierProvider<PlanModel>(
          create: (context) => PlanModel(context),
          child: PlanHomeScreen(),
        ),
        ChangeNotifierProvider<MyModel>(
          create: (context) => MyModel(context),
          child: MyScreen(),
        ),
      ];
    }

    return MultiProvider(
      providers: _models,
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _models),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontFamily: 'ProductSans'),
          unselectedLabelStyle: TextStyle(fontFamily: 'ProductSans'),
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => _currentIndex = index),
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text('记录'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('习惯'),
              icon: Icon(Icons.blur_circular),
            ),
            BottomNavigationBarItem(
              title: Text('待办'),
              icon: Icon(Icons.access_time),
            ),
            BottomNavigationBarItem(
              title: Text('个人中心'),
              icon: Icon(Icons.library_books),
            ),
          ],
        ),
      ),
    );
  }
}
