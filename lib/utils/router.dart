import 'package:flutter/material.dart';
import 'package:cocktail_recommender/diy/main/diy_main.dart';
import 'package:cocktail_recommender/diy/recipie/diy_recipie.dart';
import 'package:cocktail_recommender/diy/vault/diy_vault.dart';
import 'package:cocktail_recommender/home/home.dart';
import 'package:cocktail_recommender/discover/discover_main.dart';
import 'package:cocktail_recommender/tinder/tinder_main.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:cocktail_recommender/recommender/recommender_questionnaire.dart';
import 'package:cocktail_recommender/utils/global_vars.dart' as global;

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        debugPrint('[Router] Routing to: /');
        return MaterialPageRoute(builder: (_) => const Home());
      case '/diy':
        if (args != null) {
          debugPrint('[Router] Routing to: /diy with arguments');
          for (DrinkData drink in args as List<DrinkData>) {
            debugPrint('[Router] Drink name: ${drink.name}');
          }
          return MaterialPageRoute(
            builder: (_) => DiyPage(
              drinkList: args,
              updateBottomNavBar: true,
            ),
          );
        } else {
          debugPrint('[Router] Routing to: /diy without arguments');
          return MaterialPageRoute(
              builder: (_) => DiyPage(drinkList: global.allDrinkList));
        }
      case '/diy/vault':
        debugPrint('[Router] Routing to: /diy/vault');
        return MaterialPageRoute(builder: (_) => DiyVaultPage());
      case '/diy/recipie':
        debugPrint('[Router] Routing to: /diy/recipie');
        return MaterialPageRoute(
            builder: (_) => DiyRecipiePage(data: args as DrinkData));
      case '/discover':
        debugPrint('[Router] Routing to: /discover');
        return MaterialPageRoute(builder: (_) => const DiscoverMain());
      case '/setting':
        debugPrint('[Router] Routing to: /setting');
        return MaterialPageRoute(builder: (_) => TinderPage());
      case '/recommender':
        debugPrint('[Router] Routing to: /recommender');
        return MaterialPageRoute(
            builder: (_) => const RecommenderQuestionnaireMain());
      case '/recommender/tinder':
        if (args != null) {
          debugPrint('[Router] Routing to: /recommender/tinder with arguments');
          for (String tag in args as List<String>) {
            debugPrint('[Router] tag: $tag');
          }
          return MaterialPageRoute(builder: (_) => TinderPage(tagList: args));
        } else {
          debugPrint(
              '[Router] Routing to: /recommender/tinder without arguments');
          return MaterialPageRoute(builder: (_) => TinderPage());
        }
      default:
        debugPrint(
            '[DiyRouter] Routing to default with route: ${settings.name}');
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
