import 'package:flutter/material.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/screens/competitions/competitions.dart';
import 'package:futawesome/screens/favorites/favorites.dart';
import 'package:futawesome/screens/preferences/preferences.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  static const List<Widget> routes = <Widget>[
    Favorites(),
    Competitions(),
    Preferences()
  ];

  void onTabPress(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: routes,
      ),
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: AppColors.secondary,
        selectedItemColor: AppColors.primary,
        onTap: onTabPress,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedIconTheme: const IconThemeData(
          size: 32,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today_rounded),
            label: "Competições",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.toll_outlined),
            label: "Preferências",
          ),
        ],
      ),
    );
  }
}
