import 'package:flutter/material.dart';
import 'package:cocktail_recommender/diy/diy_main.dart';

class DiyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case 'diy/main':
        debugPrint('[DiyRouter] Routing to diy/main');
        return MaterialPageRoute(builder: (_) => const DiyMain());
      case 'diy/vault':
        debugPrint('[DiyRouter] Routing to diy/vault');
        return _errorRoute();
      case 'diy/recipie':
        debugPrint('[DiyRouter] Routing to diy/recipie');
        return _errorRoute();
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
