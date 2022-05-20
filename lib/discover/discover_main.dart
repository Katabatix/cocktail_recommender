import 'package:cocktail_recommender/discover/bar_scroller.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:flutter/material.dart';

class DiscoverMain extends StatefulWidget {
  List<DrinkData>? drinksList;
  DiscoverMain(
      {Key? key,
      this.drinksList = const <DrinkData>[]
      }) : super(key: key);

  @override
  State<DiscoverMain> createState() => _DiscoverMainState();
}

class _DiscoverMainState extends State<DiscoverMain> {
  @override
  Widget build(BuildContext context) {
    print(widget.drinksList);
    if(widget.drinksList != null){
      // debugPrint(widget.drinksList?[0].name);
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discover Bars Near You',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        body: BarScroller(drinksList: widget.drinksList),
      );
    } else{
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discover Bars Near You',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BarScroller(),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discover Bars Around You',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Container(
              color: Theme.of(context).colorScheme.background,
              child: BarScroller()),
        ));
  }
}
