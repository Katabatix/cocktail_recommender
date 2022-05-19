import 'package:cocktail_recommender/discover/bar_scroller.dart';
import 'package:flutter/material.dart';

class DiscoverMain extends StatefulWidget {
  final List<String> tagList;
  DiscoverMain({Key? key, List<String>? tagList})
      : tagList = tagList ?? <String>['tag1', 'tag2'],
        super(key: key);

  @override
  State<DiscoverMain> createState() => _DiscoverMainState();
}

class _DiscoverMainState extends State<DiscoverMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Recommender - Discover', style: TextStyle(color: Colors.white),),
      ),
      body: BarScroller(),
    );
  }
}