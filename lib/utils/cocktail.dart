import 'recipie_data.dart';

class Cocktail {
  late String name;
  late String description;
  late String imageURL;
  late List<String> ingredients;
  late List<String> steps;

  Cocktail(_name, _description, _ingredientsString, _recipe, _id) {
    name = _name;
    description = _description;
    imageURL = "http://localhost:3000/images/high%20quality/cocktails/$_id.jpg";
    //parse ingredients
    List<String> unformattedIngredients = _ingredientsString.split("|");
    //in1(11)|in2(12)|in3(13)
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
    });
    //parse recipe
    steps = _recipe.split("|");
  }

  String getName() {
    return name;
  }

  String getDescription() {
    return description;
  }

  List<String> getIngredients() {
    return ingredients;
  }

  List<String> getSteps() {
    return steps;
  }

  String getImageURL() {
    return imageURL;
  }
}
