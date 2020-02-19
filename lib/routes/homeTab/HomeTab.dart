import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yun_record/config/GlobalConfig.dart';
import 'package:yun_record/routes/my/MyScreen.dart';
import 'package:yun_record/routes/record/AddRecordModel.dart';
import 'package:yun_record/routes/record/RecordModel.dart';
import 'package:yun_record/routes/record/RecordScreen.dart';
import 'package:yun_record/routes/theme/ThemeMgScreen.dart';

class HomeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    GlobalConfig.nOn = (String route, bool remove) {
//      logOutGlobal();
//    };

    final List<SingleChildWidget> _models = [
      ChangeNotifierProvider<RecordModel>(
        create: (context) => RecordModel(context),
        child: RecordScreen(),
      ),
      ChangeNotifierProvider<AddRecordModel>(
        create: (context) => AddRecordModel(context),
        child: ThemeMgScreen(),
      ),
      ChangeNotifierProvider<AddRecordModel>(
        create: (context) => AddRecordModel(context),
        child: MyScreen(),
      ),
    ];

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
              title: Text('主题'),
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

  Future logOutGlobal() async {
    await Future.delayed(Duration.zero);
    print('my ctn logOut2');
    print(context);
    Navigator.pushNamedAndRemoveUntil(context, "Login", (Route<dynamic> route) => false);
  }
}
