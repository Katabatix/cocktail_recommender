import 'package:cocktail_recommender/discover/bar_details.dart';
import 'package:cocktail_recommender/recommender/recommender_questionnaire.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/database_helper.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  Future<List<String>> fetchTestingFromDatabase() async {
    var dbHelper = DBHelper();
    List<DrinkData> test =
        await dbHelper.getCocktailWithTags(["modern", "sad", 'excited']);
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
        automaticallyImplyLeading: false,
        title: const Text(
          'Happy Hours!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.background,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset("assets/images/app_logo")),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, RecommenderQuestionnaireMain.routeName);
                },
                child: const Text(
                  "Recommend me a Drink!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary),
              ),
            ]),
      ),
    );
  }
}
