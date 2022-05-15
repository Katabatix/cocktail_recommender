import 'package:cocktail_recommender/discover/bar_scroller.dart';
import 'package:flutter/material.dart';

class DiscoverMain extends StatefulWidget {
  const DiscoverMain({Key? key}) : super(key: key);

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
      body: const BarScroller(),
    );
  }
}