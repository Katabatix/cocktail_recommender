import 'package:flutter/material.dart';
import 'diy/diy_main.dart';
import 'DatabaseHelper.dart';

void main() {
  runApp(const CocktailRecommender());
}

class CocktailRecommender extends StatefulWidget {
  const CocktailRecommender({Key? key}) : super(key: key);
  @override
  State<CocktailRecommender> createState() => _CocktailRecommenderState();
}

class _CocktailRecommenderState extends State<CocktailRecommender> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const Page1(),
      //   '/DIY': (context) => const Page2(),
      //   '/Discover': (context) => const Page3(),
      //   '/Settings': (context) => const Page4(),
      // },
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey,
          elevation: 10,
          selectedLabelStyle: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Montserrat',
              fontSize: 14.0),
          unselectedLabelStyle: TextStyle(
              color: Colors.black, fontFamily: 'Montserrat', fontSize: 12.0),
          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final _pages = [
    const Home(),
    const DiyMain(),
    const DiscoverMain(),
    const SettingsMain(),
  ];

  @override
  Widget build(BuildContext context) {
    print("test print");
    return Scaffold(
      body: _pages[_currentIndex],
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
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Recommender - Home'),
      ),
      body: Container(
        color: const Color(0xffC4DFCB),
        child: Center(
          child: Text(
            "Home",
            style: TextStyle(
              color: Colors.green[900],
              fontSize: 45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class DiscoverMain extends StatelessWidget {
  const DiscoverMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Recommender - Discover'),
      ),
      body: Container(
        color: const Color(0xffC4DFCB),
        child: Center(
          child: Text(
            "Discover",
            style: TextStyle(
              color: Colors.green[900],
              fontSize: 45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsMain extends StatelessWidget {
  const SettingsMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Recommender - Settings'),
      ),
      body: Container(
        color: const Color(0xffC4DFCB),
        child: Center(
          child: Text(
            "Setting",
            style: TextStyle(
              color: Colors.green[900],
              fontSize: 45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
