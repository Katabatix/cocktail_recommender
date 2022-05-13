import 'package:swipe_cards/swipe_cards.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';

class TinderPage extends StatefulWidget {
  TinderPage({Key? key}) : super(key: key);

  @override
  State<TinderPage> createState() => _TinderPageState();
}

class _TinderPageState extends State<TinderPage> {
  List<DrinkData> _drinkDataList = <DrinkData>[];
  List<DrinkData> _preferredDrinkDataList = <DrinkData>[];
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  @override
  void initState() {
    _getDrinkDataList();
    _initSwipeItems();
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  void _getDrinkDataList() {
    for (int i = 0; i < 10; i++) {
      String name = "Sample Drink $i";
      RecipieData recipie = RecipieData(name: name);
      String url =
          'https://cdn.icon-icons.com/icons2/2596/PNG/512/check_one_icon_155665.png';
      List<String> tags = [
        'tag' + (i + 0).toString(),
        'tag' + (i + 1).toString(),
        'tag' + (i + 2).toString(),
      ];
      DrinkData drink = DrinkData(
          name: name,
          id: i,
          imageUrl: url,
          recipie: recipie,
          description: 'Description for $name',
          tags: tags);
      _drinkDataList.add(drink);
    }
  }

  void _initSwipeItems() {
    for (int i = 0; i < _drinkDataList.length; i++) {
      _swipeItems.add(SwipeItem(
          content: _drinkDataList[i],
          likeAction: () {
            _preferredDrinkDataList.add(_drinkDataList[i]);
            debugPrint('[Tinder] User prefer ${_drinkDataList[i].name}');
          },
          nopeAction: () {
            debugPrint('[Tinder] User nope ${_drinkDataList[i].name}');
          }));
    }
  }

  Widget _swipeCardItemBuilder(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        children: [
          Flexible(
            flex: 5,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                _swipeItems[index].content.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              _swipeItems[index].content.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              _swipeItems[index].content.description,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Do you like these?'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 9,
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: _swipeCardItemBuilder,
              onStackFinished: () {
                for (DrinkData drink in _preferredDrinkDataList) {
                  debugPrint('[Tinder] List: ${drink.id} ${drink.name}');
                }
              },
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('Nope'),
                  onPressed: () {
                    _matchEngine.currentItem?.nope();
                  },
                ),
                ElevatedButton(
                  child: const Text('Like'),
                  onPressed: () {
                    _matchEngine.currentItem?.like();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
