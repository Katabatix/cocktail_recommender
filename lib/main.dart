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
  late DBHelper db;
  late Future<List> test;
  @override
  initState() {
    print('setting init state');
    super.initState();
    db = DBHelper();
    test = db.testing();
  }

  @override
  Widget build(BuildContext context) {
    print(test);
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

  late DBHelper db;
  late Future<List> test;
  @override
  initState() {
    print('setting init state');
    super.initState();
    db = DBHelper();
    test = db.testing();
  }

  Future<List> fetchTestingFromDatabase() async {
    var dbHelper = DBHelper();
    Future<List> test = dbHelper.testing();
    return test;
  }

  void addElementToDatabase() async {}
  @override
  Widget build(BuildContext context) {
    print("test print");
    return Scaffold(
      //body:_pages[_currentIndex],
      body: Column(children: [
        FutureBuilder<List>(
          future: fetchTestingFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("HAS DATA");
              print(snapshot.data);
              return Container(
                  height: 200,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print("SNAPSHOT INDEX");
                        print(snapshot.data?[index]);
                        return Container(
                            child: Text(snapshot.data?[index]["name"] +
                                snapshot.data?[index]["description"] +
                                snapshot.data?[index]["ingredients"]));
                      }));
            } else {
              return Container(
                child: Text("No data"),
              );
            }
          },
        ),
        //FloatingActionButton(onPressed: onPressed)
      ]),
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
