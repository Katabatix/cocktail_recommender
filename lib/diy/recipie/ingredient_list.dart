import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';

class IngredientList extends StatelessWidget {
  final List<RecipieIngredient> ingredientList;

  const IngredientList({Key? key, required this.ingredientList})
      : super(key: key);

  List<Widget> constructList() {
    List<Widget> outputList = [];
    for (int i = 0; i < ingredientList.length; i++) {
      outputList.add(IngredientListItem(ingredient: ingredientList[i]));
    }
    return outputList;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 3,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: constructList(),
        ),
      ),
    );
  }
}

class IngredientListItem extends StatelessWidget {
  final RecipieIngredient ingredient;
  const IngredientListItem({Key? key, required this.ingredient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 4,
                bottom: 4,
              ),
              child: Text(
                ingredient.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(ingredient.amount.toString() + '/' + ingredient.unit),
          ),
        ],
      ),
    );
  }
}
