import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/router.dart';
import 'package:cocktail_recommender/utils/theme.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:cocktail_recommender/utils/global_vars.dart' as global;
import 'package:provider/provider.dart';
import 'utils/database_helper.dart';

void main() {
  runApp(const CocktailRecommender());
}

class CocktailRecommender extends StatefulWidget {
  const CocktailRecommender({Key? key}) : super(key: key);
  @override
  State<CocktailRecommender> createState() => _CocktailRecommenderState();
}

class _CocktailRecommenderState extends State<CocktailRecommender> {
  late DBHelper db;
  late Future<List> test;
  @override
  initState() {
    debugPrint('setting init state');
    super.initState();
    db = DBHelper();
    // test = db.getAllDrinks();
  }

  @override
  Widget build(BuildContext context) {
    // print(test);
    return ChangeNotifierProvider(
      create: (context) => NavBarIndex(),
      child: MaterialApp(
        home: const MainPage(),
        theme: getThemeData(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DBHelper db;
  late Future<List> test;
  // @override
  // initState() {
  //   print('setting init state');
  //   super.initState();
  //   db = DBHelper();
  //   test = db.testing();
  // }
  //
  // Future<List> fetchTestingFromDatabase() async {
  //   var dbHelper = DBHelper();
  //   Future<List> test = dbHelper.testing();
  //   return test;
  // }

  void addElementToDatabase() async {}

  void _getDataListFromDB() async {
    var dbHelper = DBHelper();
    List<DrinkData> drinkListNow = await dbHelper.getAllDrinks();
    global.allDrinkList = drinkListNow;
  }

  @override
  Widget build(BuildContext context) {
    _getDataListFromDB();
    var currentIndex = context.watch<NavBarIndex>();
    return Scaffold(
      body: Navigator(
          key: global.navigatorKey, onGenerateRoute: MainRouter.generateRoute),
      bottomNavigationBar: BottomNavigationBar(
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
          // BottomNavigationBarItem(
          //   label: 'Settings',
          //   icon: Icon(Icons.settings),
          // ),
        ],
        currentIndex: currentIndex.index,
        onTap: (int index) {
          currentIndex.updateIndex(index);
          switch (index) {
            case 0:
              global.navigatorKey.currentState?.pushReplacementNamed('/');
              break;
            case 1:
              global.navigatorKey.currentState?.pushReplacementNamed('/diy');
              break;
            case 2:
              global.navigatorKey.currentState
                  ?.pushReplacementNamed('/discover');
              break;
            case 3:
              global.navigatorKey.currentState
                  ?.pushReplacementNamed('/recommender/tinder');
              break;
            default:
              global.navigatorKey.currentState?.pushReplacementNamed('/error');
              break;
          }
          // setState(() {
          //   navBarIndex.updateIndex(index);
          // });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}

class NavBarIndex extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void updateIndex(int newIndex) {
    if (_index != newIndex) {
      debugPrint('[NavBarIndex] index updated: $newIndex');
      _index = newIndex;
      notifyListeners();
    }
  }
}
