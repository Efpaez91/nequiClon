import 'package:flutter/material.dart';
import 'package:nequi/src/pages/armario.dart';
import 'package:nequi/src/pages/history.dart';
import 'package:nequi/src/pages/home_page.dart';
import 'package:nequi/src/pages/notify.dart';
import 'package:nequi/src/pages/perfil.dart';
import 'package:nequi/src/utils/colores.dart';

class NavigationBarPage extends StatefulWidget {
  NavigationBarPage({Key key}) : super(key: key);

  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _currentIndex = 2;
  List<Widget> _children = [
    ArmarioPage(),
    HistoryPage(),
    HomePage(),
    NotifyPage(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color(0xff8cc6c5),
        elevation: 10,
        backgroundColor: Color(0xfff8f8f8),
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        unselectedItemColor: Color(0xffcdcdcd),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: '',
            backgroundColor: Color(0xfff8f8f8),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2_outlined),
            label: '',
            backgroundColor: Color(0xfff8f8f8),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.festival,
              color:
                  _currentIndex == 2 ? Colores.colorRosado : Color(0xffcdcdcd),
            ),
            label: '',
            backgroundColor: Color(0xfff8f8f8),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: '',
            backgroundColor: Color(0xfff8f8f8),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: '',
            backgroundColor: Color(0xfff8f8f8),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
