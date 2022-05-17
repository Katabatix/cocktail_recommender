import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_recommender/diy/main/diy_main.dart';
import 'package:cocktail_recommender/utils/global_vars.dart' as global;

class RecipieList extends StatefulWidget {
  final List<DrinkData> drinkList;
  RecipieList({
    Key? key,
    List<DrinkData>? drinkList,
  })  : drinkList = drinkList ?? <DrinkData>[],
        super(key: key);

  @override
  State<RecipieList> createState() => _RecipieListState();
}

class _RecipieListState extends State<RecipieList> {
  // static List<RecipieData> _dataList = <RecipieData>[];
  List<DrinkData> _dataList = <DrinkData>[];

  void _getDataListFromDB() {
    for (int i = 0; i < 30; i++) {
      String name = 'Sample Drink ' + i.toString();
      DrinkData drink = DrinkData(
        name: name,
        id: i,
        imageUrl:
            'https://cdn.icon-icons.com/icons2/2596/PNG/512/check_one_icon_155665.png',
        recipie: const RecipieData(),
        description: 'Description for $name',
        tags: ['tag1', 'tag2', 'tag3'],
      );
      _dataList.add(drink);
    }
  }

  List<Widget> _filterList({String query = ''}) {
    List<DrinkData> filteredList = [];
    for (int index = 0; index < _dataList.length; index++) {
      if (_dataList[index].name.contains(query)) {
        filteredList.add(_dataList[index]);
      }
    }
    return _createList(filteredList);
  }

  List<Widget> _createList(List<DrinkData> dataList) {
    List<Widget> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(RecipieListItem(data: dataList[i]));
    }
    return outputList;
  }

  @override
  void initState() {
    if (widget.drinkList.isEmpty) {
      _getDataListFromDB();
    } else {
      _dataList = widget.drinkList;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var query = context.watch<DiyRecipieQuery>();
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            _filterList(query: query.query),
          ),
        ),
      ],
    );
  }
}

class RecipieListItem extends StatelessWidget {
  final DrinkData data;

  const RecipieListItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          global.navigatorKey.currentState
              ?.pushNamed('/diy/recipie', arguments: data);
        },
        child: SizedBox(
          height: 70,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 8),
              Image.network(
                data.imageUrl,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 8),
              Text(data.name),
            ],
          ),
        ),
      ),
    );
  }
}
