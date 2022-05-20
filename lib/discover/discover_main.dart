import 'package:cocktail_recommender/discover/bar_scroller.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:flutter/material.dart';

class DiscoverMain extends StatefulWidget {

  final List<DrinkData> drinkList;
  DiscoverMain({
    Key? key,
    List<DrinkData>? drinkList,
  })  : drinkList = drinkList ?? <DrinkData>[],
        super(key: key);

  @override
  State<DiscoverMain> createState() => _DiscoverMainState();
}

class _DiscoverMainState extends State<DiscoverMain> {
  @override
  Widget build(BuildContext context) {
    if(widget.drinkList.isEmpty){
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discover Bars Near You',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            color: Theme.of(context).colorScheme.background,
            child: BarScroller()),
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discover Bars Near You',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            color: Theme.of(context).colorScheme.background,
            child: BarScroller(drinkList: widget.drinkList)),
      );
    }
  }
}
