import 'package:cocktail_recommender/discover/bar_details.dart';
import 'package:cocktail_recommender/utils/database_helper.dart';
import 'package:flutter/material.dart';

import '../utils/drink_data.dart';

class BarScroller extends StatefulWidget {
  List<DrinkData> drinksList = [];
  BarScroller({Key? key, List<DrinkData>? drinksList}) : super(key: key);

  @override
  State<BarScroller> createState() => _BarScrollerState();
}

class _BarScrollerState extends State<BarScroller> {
  List<BarInfo> barInfo = [];

  @override
  @protected
  @mustCallSuper
  void initState() {
    if (widget.drinksList.isEmpty) {
      getAllBars();
    } else {
      getBarsFromDB();
    }
    super.initState();
  }

  void getAllBars() async {
    var dbHelper = DBHelper();
    dbHelper.getAllBars().then((allBars) {
      barInfo = allBars;
      for (var bar in barInfo) {
        dbHelper.getMenuItemsWithBarId(bar.id).then((menu) => bar.menu = menu);
      }
    });
  }

  void getBarsFromDB() {
    var dbHelper = DBHelper();
    if(widget.drinksList.isNotEmpty) {
      dbHelper.getAllBarsWithDrinksIds(widget.drinksList).then((bars) {
        barInfo = bars;
        for (var bar in barInfo) {
          dbHelper.getMenuItemsWithBarId(bar.id).then((menu) => bar.menu = menu);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var dbHelper = DBHelper();
    if (widget.drinksList.isEmpty) {
      return FutureBuilder(
        future: dbHelper.getAllBars(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            itemCount: barInfo.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, BarDetails.routeName,
                        arguments: barInfo[i]);
                  },
                  title: Text(
                    barInfo[i].name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  subtitle: Column(children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      barInfo[i].description,
                      style: TextStyle(fontSize: 13.5),
                    ),
                    SizedBox(
                      height: 7.5,
                    ),
                    // Icon(
                    //   Icons.location_city,
                    //   size: 10,
                    //   color: Theme.of(context).colorScheme.primary,
                    // ),
                    //Text(barInfo[i].location),
                    // Row(children: [
                    //   // Stack(children: [
                    //   //   Align(
                    //   //       alignment: Alignment.topCenter,
                    //   //       child: Icon(
                    //   //         Icons.location_city,
                    //   //         size: 10,
                    //   //         color: Theme.of(context).colorScheme.primary,
                    //   //       ))
                    //   // ]),
                    //   Container(
                    //       width: MediaQuery.of(context).size.width * 0.5,
                    //       height: 500,
                    //       child: RichText(
                    //           text: TextSpan(text: barInfo[i].location)))
                    // ])
                  ]),
                  trailing: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 100,
                      maxHeight: 100,
                    ),
                    child: Image.network(
                        "http://10.0.2.2:3000/images/low%20quality/bars/${barInfo[i].id + 1}.jpg"),
                  ),
                  isThreeLine: true,
                  tileColor: Theme.of(context).colorScheme.onBackground,
                  textColor: Colors.white,
                ),
              );
            },
          );
        },
      );
    } else {
      return FutureBuilder(
        future: dbHelper.getAllBarsWithDrinksIds(widget.drinksList),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            itemCount: barInfo.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, BarDetails.routeName,
                        arguments: barInfo[i]);
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
                    child: Image.network(
                        "http://10.0.2.2:3000/images/low%20quality/bars/${barInfo[i].id + 1}.jpg"),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      );
    }
  }
}
