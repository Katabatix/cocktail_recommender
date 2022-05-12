import 'recipie_data.dart';

class Cocktail {
  late String name;
  late String description;
  late String imageURL;
  late List<String> ingredients;
  late List<String> steps;

  Cocktail(_name, _description, _imageURL, _ingredientsString, _recipe) {
    name = _name;
    description = _description;
    imageURL = _imageURL;
    //parse ingredients
    ingredients = _ingredientsString.split("|");
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
