import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_recommender/diy/main/diy_main.dart';

class RecipieList extends StatefulWidget {
  RecipieList({Key? key}) : super(key: key);

  @override
  State<RecipieList> createState() => _RecipieListState();
}

class _RecipieListState extends State<RecipieList> {
  final int _tempLength = 30;
  static List<RecipieData> _dataList = <RecipieData>[];
  bool initialized = false;

  void _getDataListFromDB() {
    for (int i = 0; i < _tempLength; i++) {
      String name = 'Sample Drink ' + i.toString();
      _dataList.add(RecipieData(name: name));
    }
  }

  List<Widget> _filterList({String query = ''}) {
    List<RecipieData> filteredList = [];
    for (int index = 0; index < _dataList.length; index++) {
      if (_dataList[index].name.contains(query)) {
        filteredList.add(_dataList[index]);
      }
    }
    return _createList(filteredList);
  }

  List<Widget> _createList(List<RecipieData> dataList) {
    List<Widget> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(RecipieListItem(data: dataList[i]));
    }
    return outputList;
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      _getDataListFromDB();
      initialized = true;
    }

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
  final RecipieData data;

  const RecipieListItem({Key? key, this.data = const RecipieData()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).pushNamed('/recipie', arguments: data);
        },
        child: SizedBox(
          height: 70,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 8),
              Image.network(
                data.imageURL,
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
