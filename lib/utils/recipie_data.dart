class RecipieData {
  // final String name;
  late List<RecipieIngredient> ingredients;
  // final String imageURL;
  late List<String> steps;

  RecipieData({
    // this.name = 'Sample Drink',
    this.ingredients = const [
      RecipieIngredient(name: 'ing 1'),
      RecipieIngredient(name: 'ing 2', amount: "1"),
      RecipieIngredient(name: 'ing 3', amount: "1"),
      RecipieIngredient(
          name: 'ing 444 444444444 444444 444444444444 444444', amount: "1"),
      RecipieIngredient(name: 'ing 5', amount: "1"),
      RecipieIngredient(name: 'ing 6', amount: "1"),
      RecipieIngredient(name: 'ing 7', amount: "1"),
      RecipieIngredient(name: 'ing 8', amount: "1"),
      RecipieIngredient(name: 'ing 9', amount: "1"),
      RecipieIngredient(name: 'ing 10', amount: 'tons')
    ],
    this.steps = const [
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
    ],
  });

  @override
  String toString() {
    return 'ingredients: ' +
        ingredients.toString() +
        ', steps: ' +
        steps.toString();
  }
}

class RecipieIngredient {
  final String name;
  final String amount;
  //final String unit;

  const RecipieIngredient({
    this.name = 'Sample Ingredient',
    this.amount = "45ml",
    //this.unit = 'ml',
  });

  @override
  String toString() {
    return name + ' ' + amount.toString();
  }
}
