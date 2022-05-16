import 'package:cocktail_recommender/discover/bar_details.dart';
import 'package:cocktail_recommender/discover/menu_details.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:flutter/material.dart';

import '../utils/recipie_data.dart';

class BarScroller extends StatefulWidget {
  const BarScroller({Key? key}) : super(key: key);

  @override
  State<BarScroller> createState() => _BarScrollerState();
}

class _BarScrollerState extends State<BarScroller> {
  MenuInfo testMenu = MenuInfo(<DrinkData>[
    DrinkData(name: "TestDrink", id: 1, imageUrl: "testurl", recipie: const RecipieData(), description: "description", tags: ["tags"])
  ], <DrinkPrices>[
    DrinkPrices(1, "100 HKD")
  ]);


  List<BarInfo> barInfo = [];

  //replace with getting from DB
  void _createBarItems(){
    for (var i = 0; i < 30; i++){
      barInfo.add(BarInfo("Name$i", "location$i", i%6, i, testMenu));
    }
  }

  void _makeMockData(){

  }

  @override
  Widget build(BuildContext context) {
    _createBarItems();
    print(barInfo);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      itemCount: barInfo.length,
      itemBuilder: (context, i) {
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(
                  context,
                  BarDetails.routeName,
                  arguments: barInfo[i]
              );
            },
            title: Text(barInfo[i].name),
            subtitle: Text(barInfo[i].location),
            trailing: ConstrainedBox(
                constraints: const BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 100,
                maxHeight: 100,
              ),
              child: Image.asset('assets/bar_icons/bar$i.jpg', fit: BoxFit.cover),
            ),
            isThreeLine: true,
          ),
        );
      }
    );
  }
}