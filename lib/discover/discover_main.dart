import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
        title: const Text('Cocktail Recommender - Discover'),
      ),
      body: BarScroller(),
    );
  }
}

class BarInfo {
  String name;
  String location;

  BarInfo(this.name, this.location);
}

class BarScroller extends StatefulWidget {
  const BarScroller({Key? key}) : super(key: key);

  @override
  State<BarScroller> createState() => _BarScrollerState();
}

class _BarScrollerState extends State<BarScroller> {
  bool _showSelectedBar = false;
  int _selectedBar = 0;

  List<BarInfo> barInfo = [
    BarInfo("12345464861513131653", "a really really long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long address"),
    BarInfo("2", "b"),
    BarInfo("3", "c"),
    BarInfo("4", "d"),
    BarInfo("5", "e"),
    BarInfo("6", "f"),
    BarInfo("7", "g"),
    BarInfo("8", "h"),
  ];

  @override
  Widget build(BuildContext context) {
    if(!_showSelectedBar){
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        itemCount: barInfo.length,
        itemBuilder: (context, i){
          return Card(
            child: ListTile(
              onTap: () {
                setState(() {
                  _showSelectedBar = true;
                  _selectedBar = i;
                });
              },
              title: Text(barInfo[i].name),
              subtitle: Text(barInfo[i].location),
              isThreeLine: true,
            ),
          );
        },

      );
    }
    else{
      return BarDetails(
        barInfo[_selectedBar].name,
        barInfo[_selectedBar].location,
        () {
          setState(() {
            _showSelectedBar = false;
          });
        }
      );
    }
  }
}

class BarDetails extends StatelessWidget {
  BarDetails(this.name, this.address, this.goBack);

  final String name;
  final String address;
  final VoidCallback goBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          ElevatedButton.icon(onPressed: goBack, icon: Icon(Icons.arrow_back), label: Text("Hello")),
          Text(name),
          Text(address),
        ],
      ),
    );
  }
}
