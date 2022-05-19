import 'package:cocktail_recommender/discover/bar_details.dart';
import 'package:cocktail_recommender/utils/database_helper.dart';
import 'package:flutter/material.dart';

class BarScroller extends StatefulWidget {
  final List<String> tagList;
  const BarScroller({Key? key, required this.tagList}) : super(key: key);

  @override
  State<BarScroller> createState() => _BarScrollerState();
}

class _BarScrollerState extends State<BarScroller> {
  List<BarInfo> barInfo = [];

  @override
  @protected
  @mustCallSuper
  void initState() {
    getAllBars();
    super.initState();
  }

  Future<List> getDrinksFromDB() async {
    var dbHelper = DBHelper();
    return dbHelper.getAllDrinks();
  }

  void getAllBars() async {
    var dbHelper = DBHelper();
    dbHelper.getAllBars().then((allBars) => barInfo = allBars);
  }

  void getBarsFromDB() {}

  @override
  Widget build(BuildContext context) {
    var dbHelper = DBHelper();
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
                  Navigator.pushNamed(
                      context, BarDetails.routeName, arguments: barInfo[i]);
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
