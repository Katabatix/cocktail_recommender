import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'package:cocktail_recommender/diy/recipie/ingredient_list.dart';
import 'package:cocktail_recommender/diy/recipie/step_list.dart';

class DiyRecipiePage extends StatelessWidget {
  final RecipieData data;

  const DiyRecipiePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
      ),
      body: Column(
        children: [
          DiyRecipieTop(data: data),
          RecipieStepList(steps: data.steps)
        ],
      ),
    );
  }
}

class DiyRecipieTop extends StatelessWidget {
  final RecipieData data;
  const DiyRecipieTop({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[100],
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IngredientList(ingredientList: data.ingredients),
              Image.network(
                data.imageURL,
                width: MediaQuery.of(context).size.width / 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
