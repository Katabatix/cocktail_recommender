import 'package:swipe_cards/swipe_cards.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:cocktail_recommender/utils/global_vars.dart' as global;

class TinderPage extends StatefulWidget {
  final List<String> tagList;
  TinderPage({Key? key, List<String>? tagList})
      : tagList = tagList ?? <String>['tag1', 'tag2'],
        super(key: key);

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
    debugPrint('[Tinder] initState');
    _getDrinkDataList();
    _filterDrinkDataListWithTags();
    _initSwipeItems();
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  void _getDrinkDataList() {
    _drinkDataList = global.allDrinkList;
  }

  void _filterDrinkDataListWithTags() {
    List<DrinkData> filteredList = <DrinkData>[];
    for (DrinkData drink in _drinkDataList) {
      drink.rateTags(widget.tagList);
      if (drink.score > 0) {
        filteredList.add(drink);
      }
    }
    filteredList.sort((p1, p2) {
      return Comparable.compare(p2.score, p1.score);
    });
    _drinkDataList = filteredList;
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
                _swipeItems[index].content.highQualityImageUrl,
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
          Flexible(
            flex: 1,
            child: Text(_swipeItems[index].content.tags.join(', ').toString()),
          )
        ],
      ),
    );
  }

  void _stackFinished() {
    for (DrinkData drink in _preferredDrinkDataList) {
      debugPrint('[Tinder] List: ${drink.id} ${drink.name}');
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('It\'s time'),
          content: const Text('You would like to DIY or BUY?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                global.navigatorKey.currentState?.pushReplacementNamed(
                  '/diy',
                  arguments: _preferredDrinkDataList,
                );
              },
              child: const Text('DIY'),
            ),
            TextButton(
              onPressed: () {
                global.navigatorKey.currentState?.pushReplacementNamed(
                  '/discover',
                  arguments: _preferredDrinkDataList,
                );
              },
              child: const Text('BUY'),
            ),
          ]),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: _swipeCardItemBuilder,
                onStackFinished: _stackFinished,
              ),
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
