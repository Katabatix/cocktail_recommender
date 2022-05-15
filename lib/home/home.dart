import 'package:cocktail_recommender/recommender/recommender_questionnaire.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Recommender - Home', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: ElevatedButton(
            onPressed:() {
              Navigator.pushNamed(context, RecommenderQuestionnaireMain.routeName);
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
    );
  }
}