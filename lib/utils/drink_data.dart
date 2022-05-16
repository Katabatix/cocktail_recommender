import 'package:cocktail_recommender/utils/recipie_data.dart';

class DrinkData {
  String name;
  int id;
  String imageUrl;
  RecipieData recipie;
  String description;
  List<String> tags;
  int score;

  DrinkData(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.recipie,
      required this.description,
      required this.tags,
      this.score = 0});

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
