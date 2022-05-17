import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'recipie_data.dart';

class DrinkData {
  late String name;
  late int id;
  late String imageUrl;
  late RecipieData recipie;
  late String description;
  late List<String> tags;
  late int score;

  DrinkData.fromBackend(
      _name, _description, _ingredientsString, _recipeSteps, _id) {
    name = _name;
    description = _description;
    imageUrl = "http://localhost:3000/images/high%20quality/cocktails/$_id.jpg";
    List<String> unformattedIngredients = _ingredientsString.split("|");
    recipie = RecipieDatafromLongStrings(unformattedIngredients, _recipeSteps);
    tags = ["tag1", "tag2"];
    score = 0;
  }

  DrinkData(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.recipie,
      required this.description,
      required this.tags,
      this.score = 0});

  RecipieDatafromLongStrings(unformattedIngredients, recipeSteps) {
    List<String> _steps = recipeSteps.split('|');
    List<RecipieIngredient> _ingredients = [];
    unformattedIngredients.forEach((element) {
      String ingredient = "";
      String quantity = "";
      int current = 0;
      bool quantityMode = false;
      while (current < element.length) {
        if (element[current] == "(") {
          quantityMode = true;
        } else if (element[current] == "(") {
          print("ended");
        } else if (!quantityMode) {
          ingredient += element[current];
        } else {
          quantity += element[current];
        }
        current += 1;
      }
      _ingredients.add(RecipieIngredient(name: ingredient, amount: quantity));
    });

    return RecipieData(ingredients: _ingredients, steps: _steps);
  }

  String getName() {
    return name;
  }

  String getDescription() {
    return description;
  }

  RecipieData getRecipieData() {
    return recipie;
  }

  String getImageURL() {
    return imageUrl;
  }

  void rateTags(List<String> preferredTags) {
    int newScore = 0;
    for (String preferredTag in preferredTags) {
      if (tags.contains(preferredTag)) {
        newScore++;
      }
    }
    score = newScore;
  }
}
