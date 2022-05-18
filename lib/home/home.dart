import 'package:cocktail_recommender/discover/menu_details.dart';
import 'package:cocktail_recommender/recommender/recommender_questionnaire.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/database_helper.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  Future<List<String>> fetchTestingFromDatabase() async {
    var dbHelper = DBHelper();
    List<MenuItem> test = await dbHelper.getMenuItemsWithBarId(0);
    List<String> temp = [];
    for (var element in test) {
      String curr = element.drink.getName();
      temp.add(curr);
    }
    return temp;
  }

  Future<List<String>> fetchTestingFromDatabaseAllDrinks() async {
    var dbHelper = DBHelper();
    List<DrinkData> test = await dbHelper.getAllDrinks();
    List<String> temp = [];
    test.forEach((element) {
      String curr = element.getName();
      temp.add(curr);
    });
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cocktail Recommender - Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(children: [
        FutureBuilder<List>(
          future: fetchTestingFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("HAS DATA");
              print(snapshot.data);
              return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print("SNAPSHOT INDEX");
                        print(snapshot.data);
                        return Text(
                          snapshot.data?[index],
                          style: const TextStyle(color: Colors.amber),
                        );
                        //  +
                        //     snapshot.data?[index]["description"] +
                        //     snapshot.data?[index]["ingredients"]));
                      }));
            } else {
              return const Text("No data");
            }
          },
        ),
        Container(
          color: Theme.of(context).colorScheme.background,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, RecommenderQuestionnaireMain.routeName);
              },
              child: const Text(
                "Recommend me a Drink!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            ),
          ),
        ),
        //FloatingActionButton(onPressed: onPressed)
      ]),
    );
  }
}
