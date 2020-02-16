import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yun_record/models/HomeModel.dart';
import 'package:yun_record/routes/home/HomeScreen.dart';
import 'package:yun_record/routes/my/MyScreen.dart';

/// This view holds all tabs & its models: home, vehicles, upcoming & latest launches, & company tabs.
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
    final List<SingleChildWidget> _models = [
      ChangeNotifierProvider<HomeModel>(
        create: (context) => HomeModel(context),
        child: HomeScreen(),
      ),
      ChangeNotifierProvider<HomeModel>(
        create: (context) => HomeModel(context),
        child: MyScreen(),
      ),
      ChangeNotifierProvider<HomeModel>(
        create: (context) => HomeModel(context),
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
              title: Text('首页'),
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
}
