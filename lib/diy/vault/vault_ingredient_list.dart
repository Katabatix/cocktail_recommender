import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/vault_ingredient_data.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_recommender/diy/vault/diy_vault.dart';
import 'package:cocktail_recommender/utils/database_helper.dart';

class VaultIngredientList extends StatefulWidget {
  const VaultIngredientList({Key? key}) : super(key: key);

  @override
  State<VaultIngredientList> createState() => _VaultIngredientListState();
}

class _VaultIngredientListState extends State<VaultIngredientList> {
  static List<VaultIngredientData> _dataList = <VaultIngredientData>[];
  bool initialized = false;
  void _getDataListFromDB() {
    //todo Get datalist
    // _dataList = <VaultIngredientData>[
    //   VaultIngredientData(name: 'ingredient 1', id: 1, status: true),
    //   VaultIngredientData(name: 'ingredient 2', id: 2, status: true),
    //   VaultIngredientData(name: 'ingredient 3', id: 3, status: true),
    //   VaultIngredientData(name: 'ingredient 4', id: 4, status: false),
    //   VaultIngredientData(name: 'ingredient 5', id: 5, status: false),
    //   VaultIngredientData(name: 'ingredient 6', id: 6, status: false),
    //   VaultIngredientData(name: 'ingredient 7', id: 7, status: true),
    //   VaultIngredientData(name: 'ingredient 8', id: 8, status: true),
    //   VaultIngredientData(name: 'ingredient 9', id: 9, status: true),
    //   VaultIngredientData(name: 'ingredient 10', id: 10, status: true),
    // ];
  }
  void _updateListInDB() {
    var db = DBHelper();
    db.saveAllIngredients(_dataList);
  }

  @override
  void initState() {
    super.initState();
    _fetchDataList();
  }

  void _fetchDataList() async {
    var dbHelper = DBHelper();
    Future<List<VaultIngredientData>> futureList = dbHelper.getAllIngredients();
    _dataList = await futureList;
  }

  void _handleItemStateChanged(int id) async {
    setState(() {
      _dataList[_getIndexFromID(id)].status =
          !_dataList[_getIndexFromID(id)].status;
    });
    _updateListInDB();
  }

  int _getIndexFromID(int id) {
    int index = 0;
    while (_dataList[index].id != id) {
      index++;
    }
    return index;
  }

  List<Widget> _createList(List<VaultIngredientData> dataList) {
    List<Widget> outputList = [];
    for (int index = 0; index < dataList.length; index++) {
      outputList.add(VaultIngredientListItem(
        data: dataList[index],
        onChanged: _handleItemStateChanged,
      ));
    }
    return outputList;
  }

  List<Widget> _filterList({String query = ''}) {
    List<VaultIngredientData> filteredList = [];
    for (int index = 0; index < _dataList.length; index++) {
      if (_dataList[index].name.contains(query)) {
        filteredList.add(_dataList[index]);
      }
    }
    return _createList(filteredList);
  }

  void _printDataList() {
    debugPrint('[List] Here is the data list from list');
    for (int i = 0; i < _dataList.length; i++) {
      debugPrint(_dataList[i].toString());
    }
  }

  @override
  void dispose() {
    debugPrint('[Vault] TODO: save current data list back to database.');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dbHelper = DBHelper();
    if (!initialized) {
      _getDataListFromDB();
      initialized = true;
    }
    _printDataList();
    var query = context.watch<VaultIngredientQuery>();
    return Expanded(
      child: FutureBuilder(
        future: dbHelper.getAllIngredients(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return ListView(
            padding: const EdgeInsets.all(8),
            children: _filterList(query: query.query),
          );
        },
      ),
    );
  }
}

class VaultIngredientListItem extends StatefulWidget {
  final VaultIngredientData data;
  final ValueChanged<int> onChanged;

  const VaultIngredientListItem({
    Key? key,
    required this.data,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<VaultIngredientListItem> createState() =>
      _VaultIngredientListItemState();
}

class _VaultIngredientListItemState extends State<VaultIngredientListItem> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //     padding: EdgeInsets.all(10),
    //     color: Theme.of(context).colorScheme.background,
    //     child:
    return Card(
            color: Theme.of(context).colorScheme.background.withOpacity(0.5),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        widget.data.iconUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      widget.data.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: VaultIngredientListItemButton(
                      data: widget.data,
                      onChanged: widget.onChanged,
                    ),
                  ),
                ],
              ),
            ))
        //)
        ;
  }
}

class VaultIngredientListItemButton extends StatefulWidget {
  final VaultIngredientData data;
  final ValueChanged<int> onChanged;

  const VaultIngredientListItemButton({
    Key? key,
    required this.data,
    required this.onChanged,
  }) : super(key: key);
  @override
  State<VaultIngredientListItemButton> createState() =>
      _VaultIngredientListItemButtonState();
}

class _VaultIngredientListItemButtonState
    extends State<VaultIngredientListItemButton> {
  void _updateIngredientStatus() {
    debugPrint('[Vault] Toggle ingredient: ' + widget.data.name);
    widget.onChanged(widget.data.id);
  }

  void _printDataList() {
    debugPrint('[Vault Button] ' +
        widget.data.id.toString() +
        ' ' +
        widget.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    _printDataList();
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                  color: !widget.data.status ? Colors.green : Colors.red),
            ),
          ),
          TextButton(
            child: Icon(
                !widget.data.status
                    ? Icons.add_circle_outline_rounded
                    : Icons.remove_circle_outline_rounded,
                color: Colors.white),
            onPressed: _updateIngredientStatus,
          ),
        ],
      ),
    );
  }
}
