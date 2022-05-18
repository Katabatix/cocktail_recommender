import 'package:cocktail_recommender/discover/bar_details.dart';
import 'package:cocktail_recommender/discover/menu_details.dart';
import 'package:cocktail_recommender/recommender/recommender_questionnaire.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'package:cocktail_recommender/utils/vault_ingredient_data.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/database_helper.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  Future<List<String>> fetchTestingFromDatabase() async {
    var dbHelper = DBHelper();
    List<VaultIngredientData> test = await dbHelper.getAllIngredients();
    List<String> temp = [];
    test.forEach((element) {
      String curr = element.name;
      temp.add(curr);
    });
    return temp;
  }

  Future<List<String>> fetchTestingFromDatabase2() async {
    var dbHelper = DBHelper();
    List<DrinkData> testDrinks = [];
    testDrinks.add(DrinkData(
        name: "name",
        id: 1,
        highQualityImageUrl: "highQualityImageUrl",
        lowQualityImageUrl: "lowQualityImageUrl",
        recipie: RecipieData(ingredients: const [
          RecipieIngredient(name: 'ing 1'),
          RecipieIngredient(name: 'ing 2', amount: "1"),
          RecipieIngredient(name: 'ing 3', amount: "1"),
          RecipieIngredient(
              name: 'ing 444 444444444 444444 444444444444 444444',
              amount: "1"),
          RecipieIngredient(name: 'ing 5', amount: "1"),
          RecipieIngredient(name: 'ing 6', amount: "1"),
          RecipieIngredient(name: 'ing 7', amount: "1"),
          RecipieIngredient(name: 'ing 8', amount: "1"),
          RecipieIngredient(name: 'ing 9', amount: "1"),
          RecipieIngredient(name: 'ing 10', amount: 'tons')
        ], steps: const [
          'step1',
          'step2',
          'step3',
          'step4',
          'step5',
          'step6',
          'step7',
          'step88888888888888888888888888888888888888888888888888888888888',
          'step9',
          'step10'
        ]),
        description: "description",
        tags: ["tags"]));

    testDrinks.add(DrinkData(
        name: "name",
        id: 3,
        highQualityImageUrl: "highQualityImageUrl",
        lowQualityImageUrl: "lowQualityImageUrl",
        recipie: RecipieData(ingredients: const [
          RecipieIngredient(name: 'ing 1'),
          RecipieIngredient(name: 'ing 2', amount: "1"),
          RecipieIngredient(name: 'ing 3', amount: "1"),
          RecipieIngredient(
              name: 'ing 444 444444444 444444 444444444444 444444',
              amount: "1"),
          RecipieIngredient(name: 'ing 5', amount: "1"),
          RecipieIngredient(name: 'ing 6', amount: "1"),
          RecipieIngredient(name: 'ing 7', amount: "1"),
          RecipieIngredient(name: 'ing 8', amount: "1"),
          RecipieIngredient(name: 'ing 9', amount: "1"),
          RecipieIngredient(name: 'ing 10', amount: 'tons')
        ], steps: const [
          'step1',
          'step2',
          'step3',
          'step4',
          'step5',
          'step6',
          'step7',
          'step88888888888888888888888888888888888888888888888888888888888',
          'step9',
          'step10'
        ]),
        description: "description",
        tags: ["tags"]));
    List<BarInfo> test = await dbHelper.getAllBarsWithDrinksIds(testDrinks);
    List<String> temp = [];
    test.forEach((element) {
      String curr = element.name;
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
          future: fetchTestingFromDatabase2(),
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
