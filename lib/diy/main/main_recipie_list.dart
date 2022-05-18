import 'package:cocktail_recommender/diy/vault/vault_ingredient_list.dart';
import 'package:cocktail_recommender/utils/vault_ingredient_data.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_recommender/diy/main/diy_main.dart';
import 'package:cocktail_recommender/utils/global_vars.dart' as global;
import 'package:cocktail_recommender/utils/database_helper.dart';

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
  List<String> listOfVaultItems = [];

  Future<String> _fetchVaultDataList() async {
    print("FETCH VAULT TRIGGERED");
    listOfVaultItems = [];
    var dbHelper = DBHelper();
    Future<List<VaultIngredientData>> futureList = dbHelper.getAllIngredients();
    List<VaultIngredientData> currentVaultIngredients = await futureList;
    for (var ingredient in currentVaultIngredients) {
      if (ingredient.status) listOfVaultItems.add(ingredient.name);
    }
    print("LIST IN FETCH");
    print(listOfVaultItems);
    return listOfVaultItems.isNotEmpty ? listOfVaultItems[0] : "no data";
  }

  void _getDataListFromDB() {
    for (int i = 0; i < 30; i++) {
      String name = 'Sample Drink ' + i.toString();
      DrinkData drink = DrinkData(
        name: name,
        id: i,
        highQualityImageUrl:
            'https://cdn.icon-icons.com/icons2/2596/PNG/512/check_one_icon_155665.png',
        lowQualityImageUrl:
            'https://cdn.icon-icons.com/icons2/2596/PNG/512/check_one_icon_155665.png',
        recipie: RecipieData(),
        description: 'Description for $name',
        tags: ['tag1', 'tag2', 'tag3'],
      );
      _dataList.add(drink);
    }
  }

  List<Widget> _filterList(
      {List<String> query = const [
        '',
      ]}) {
    List<DrinkData> filteredList = [];
    List<int> alreadyAdded = [];
    for (var currentQuery in query) {
      for (int index = 0; index < _dataList.length; index++) {
        if (_dataList[index]
            .comibnedFieldsForSearch
            .toLowerCase()
            .contains(currentQuery.toLowerCase())) {
          if (!alreadyAdded.contains(_dataList[index].id)) {
            alreadyAdded.add(_dataList[index].id);
            filteredList.add(_dataList[index]);
          }
        }
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
    _fetchVaultDataList();
    super.initState();
  }

  bool queryingFromVault = false;

  void toggleVault() async {
    String temp = await _fetchVaultDataList();
    print("TOGGLE TRIGGERD");
    print("LIST OF VAULT ITEMS");
    for (var x in listOfVaultItems) {
      print(x);
    }
    if (listOfVaultItems.isEmpty) {
      final snackBar = SnackBar(
          content: Text("Your Vault is Empty! Please update it first"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    var query = context.read<DiyRecipieQuery>();
    query.updateQuery(listOfVaultItems);
    //query.updateQuery(['drink 1', 'drink 2']);
    debugPrint('[Recipie Mian] query: ' + query.query[0]);
  }

  @override
  Widget build(BuildContext context) {
    //_fetchVaultDataList();
    var query = context.watch<DiyRecipieQuery>();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ElevatedButton(
            child: Text("Recommend based on Vault"),
            onPressed: toggleVault,
          ),
        ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    data.lowQualityImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
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
