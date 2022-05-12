import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'package:cocktail_recommender/diy/diy_main.dart';
import 'package:cocktail_recommender/diy/recipie/diy_recipie.dart';

class DiyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        debugPrint('[DiyRouter] Routing to /');
        return MaterialPageRoute(builder: (_) => const DiyMainPage());
      case '/vault':
        debugPrint('[DiyRouter] Routing to /vault');
        return _errorRoute();
      case '/recipie':
        debugPrint(
            '[DiyRouter] Routing to /recipie with data: ' + args.toString());
        return MaterialPageRoute(
            builder: (context) => DiyRecipiePage(data: args as RecipieData));
      default:
        debugPrint('[DiyRouter] Routing to default');
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Error')),
      );
    });
  }
}
