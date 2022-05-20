import 'package:flutter/material.dart';
import 'package:cocktail_recommender/diy/recipie/ingredient_list.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:cocktail_recommender/diy/recipie/step_list.dart';

class DiyRecipiePage extends StatelessWidget {
  final DrinkData data;

  const DiyRecipiePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          DiyRecipieTop(data: data),
          RecipieStepList(steps: data.recipie.steps)
        ],
      ),
    );
  }
}

class DiyRecipieTop extends StatelessWidget {
  final DrinkData data;
  const DiyRecipieTop({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      height: MediaQuery.of(context).size.width / 2.5,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            IngredientList(ingredientList: data.recipie.ingredients),
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                data.lowQualityImageUrl,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
