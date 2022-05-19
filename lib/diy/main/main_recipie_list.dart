import 'package:cocktail_recommender/utils/vault_ingredient_data.dart';
import 'package:cocktail_recommender/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_recommender/diy/main/diy_main.dart';
import 'package:cocktail_recommender/utils/global_vars.dart' as global;
import 'dart:async';

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

  ///deprecated testData function
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
        tags: 'tag1 tag2 tag3',
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
    if (dataList.isEmpty) {
      outputList.add(Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Center(
          child: Text(
            "Sorry we found no matches :(",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ]));
      return outputList;
    }
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(RecipieListItem(
        data: dataList[i],
        vaultIngredients: listOfVaultItems,
      ));
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
        // SliverToBoxAdapter(
        //     child: ElevatedButton(
        //   child: Text(
        //     "Recommend Based on Vault Ingredients",
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   ),
        //   onPressed: toggleVault,
        // ),

        // ),
        SliverAppBar(
          automaticallyImplyLeading: false,
          title: ElevatedButton(
            child: const Text(
              "Recommend Based on Vault Ingredients",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: toggleVault,
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(400, 40))),
          ),
          pinned: true,
          backgroundColor: Theme.of(context).colorScheme.background,
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
  List<String> vaultIngredients;

  RecipieListItem({
    Key? key,
    required this.data,
    required this.vaultIngredients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primary,
        onTap: () {
          global.navigatorKey.currentState
              ?.pushNamed('/diy/recipie', arguments: data);
        },
        child: SizedBox(
          height: 90,
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
              Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  //color: Colors.orange,
                  child: Text(
                    data.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        //color: Theme.of(context).colorScheme.primary,
                        color: Colors.white.withOpacity(0.9)),
                  )),
            ],
          ),
        ),
      ),
      color: Theme.of(context).colorScheme.onBackground,
      // color: data.recipie.ingredients.any((rIngredient) => vaultIngredients
      //         .any((vIngredient) => vIngredient == rIngredient.name))
      //     ? Colors.white
      //     : Colors.pink[200],
    );
  }
}
