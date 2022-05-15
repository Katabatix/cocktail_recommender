import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/global_vars.dart' as globals;

Widget bottomNavBar(BuildContext context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: const [
      BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        label: 'DIY',
        icon: Icon(Icons.list),
      ),
      BottomNavigationBarItem(
        label: 'Discover',
        icon: Icon(Icons.map),
      ),
      BottomNavigationBarItem(
        label: 'Settings',
        icon: Icon(Icons.settings),
      ),
    ],
    currentIndex: globals.botNavBarCurrentIndex,
    onTap: (int index) {
      switch (index) {
        case 0:
          Navigator.of(context).pushNamed('/');
          break;
        case 1:
          Navigator.of(context).pushNamed('/diy');
          break;
        case 2:
          Navigator.of(context).pushNamed('/discover');
          break;
        case 3:
          Navigator.of(context).pushNamed('/setting');
          break;
        default:
          Navigator.of(context).pushNamed('error');
          break;
      }
    },
  );
}
