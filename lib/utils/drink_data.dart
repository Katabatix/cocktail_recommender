import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'recipie_data.dart';

class DrinkData {
  late String name;
  late int id;
  late String highQualityImageUrl;
  late String lowQualityImageUrl;
  late RecipieData recipie;
  late String description;
  late String comibnedFieldsForSearch;
  late String tags;
  late int score;

  @override
  String toString() {
    return "name: $name, id: ${id.toString()}, highQualityImageUrl: $highQualityImageUrl, lowQualityImageUrl: $lowQualityImageUrl";
  }

  DrinkData.fromBackend(
      _name, _description, _ingredientsString, _recipeSteps, _id, _tags) {
    comibnedFieldsForSearch =
        _name + _description + _ingredientsString + _recipeSteps;
    name = _name;
    id = _id;
    description = _description;
    highQualityImageUrl =
        "http://10.0.2.2:3000/images/high%20quality/cocktails/$_id.jpg";
    // "http://10.0.2.2:3000/images/high%20quality/cocktails/1.jpg";
    lowQualityImageUrl =
        "http://10.0.2.2:3000/images/low%20quality/cocktails/$_id.jpg";
    // "http://10.0.2.2:3000/images/low%20quality/cocktails/1.jpg";
    List<String> unformattedIngredients = _ingredientsString.split("|");
    recipie = RecipieDatafromLongStrings(unformattedIngredients, _recipeSteps);
    tags = _tags;
    score = 0;
  }

  DrinkData(
      {required this.name,
      required this.id,
      required this.highQualityImageUrl,
      required this.lowQualityImageUrl,
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

  String getHighQualityImageURL() {
    return highQualityImageUrl;
  }

  String getLowQualityImageURL() {
    return lowQualityImageUrl;
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
