import 'package:cocktail_recommender/utils/database_helper.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:cocktail_recommender/utils/global_vars.dart' as global;

class TinderPage extends StatefulWidget {
  final List<String> tagList;
  TinderPage({Key? key, List<String>? tagList})
      : tagList = tagList ?? <String>['calm', 'happy'],
        super(key: key);

  @override
  State<TinderPage> createState() => _TinderPageState();
}

class _TinderPageState extends State<TinderPage> {
  List<DrinkData> _drinkDataList = <DrinkData>[];
  List<DrinkData> _preferredDrinkDataList = <DrinkData>[];
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  bool loadedItems = false;

  @override
  void initState() {
    debugPrint('[Tinder] initState');
    _getDrinkDataList();
    //_filterDrinkDataListWithTags();
    //_initSwipeItems();
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  Future<String> _getDrinkDataList() async {
    var dbhelper = DBHelper();
    _drinkDataList = await dbhelper.getCocktailWithTags(widget.tagList);
    loadedItems = true;
    setState(() {});
    return "temp";
  }

  void _initSwipeItems() {
    //String temp = await _getDrinkDataList();
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
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Flexible(
              flex: 5,
              // child: AspectRatio(
              //     aspectRatio: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                child: Image.network(
                  _swipeItems[index].content.highQualityImageUrl,
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 1,
            child: Text(
              _swipeItems[index].content.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary, //Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 1,
            child: Text(
              _swipeItems[index].content.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  void _stackFinished() {
    for (DrinkData drink in _preferredDrinkDataList) {
      debugPrint('[Tinder] List: ${drink.id} ${drink.name}');
    }
    if (_preferredDrinkDataList.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: const Text('It\'s time for Happy Hours!'),
            content: const Text('Would you like to DIY or BUY?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (global.navigatorKey.currentState != null) {
                    global.navigatorKey.currentState?.pushReplacementNamed(
                      '/diy',
                      arguments: _preferredDrinkDataList,
                    );
                  }
                },
                child: const Text('DIY'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (global.navigatorKey.currentState != null) {
                    global.navigatorKey.currentState?.pushReplacementNamed(
                      '/discover',
                      arguments: _preferredDrinkDataList,
                    );
                  }
                },
                child: const Text('BUY'),
              ),
            ]),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: const Text('Oh no! You did not like any of the drinks :('),
            content: Text('Retry the quiz for better recommendations'),
            //const Text('Would like to go back to HOME or REDO the quiz?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (global.navigatorKey.currentState != null) {
                    global.navigatorKey.currentState?.pushReplacementNamed(
                      '/',
                      arguments: _preferredDrinkDataList,
                    );
                  }
                },
                child: const Text('Okay'),
              ),
              // TextButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //     if (global.navigatorKey.currentState != null) {
              //       global.navigatorKey.currentState?.pushReplacementNamed(
              //         '/discover',
              //         arguments: _preferredDrinkDataList,
              //       );
              //     }
              //   },
              //   child: const Text('REDO'),
              // ),
            ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //String temp = await _getDrinkDataList();
    if (!loadedItems) {
      return Container(
        height: 50,
        width: 50,
        color: Colors.amber,
      );
    }
    _initSwipeItems();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Do you like this Drink?',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              Flexible(
                flex: 10,
                child: SwipeCards(
                  matchEngine: _matchEngine,
                  itemBuilder: _swipeCardItemBuilder,
                  onStackFinished: _stackFinished,
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text(
                        'Nope',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        if (_matchEngine.currentItem != null) {
                          _matchEngine.currentItem!.nope();
                        }
                      },
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Like',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      onPressed: () {
                        if (_matchEngine.currentItem != null) {
                          _matchEngine.currentItem!.like();
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
