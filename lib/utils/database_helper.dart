import 'dart:async';
import 'dart:io' as io;
import 'package:cocktail_recommender/utils/drink_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:cocktail_recommender/discover/bar_details.dart';
import 'package:flutter/services.dart' show rootBundle;
import '/discover/menu_details.dart' as menu;
import 'package:cocktail_recommender/utils/vault_ingredient_data.dart';

//...
class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db; //UNCOMMENT
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    Map<String, dynamic> temp = await rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
    return temp;
  }

  void _onCreate(Database db, int version) async {
    Map<String, dynamic> dmap =
        await parseJsonFromAssets('assets/test_json.json');

    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE IF NOT EXISTS cocktails (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, ingredients TEXT NOT NULL, recipe TEXT NOT NULL);");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS  bars (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, contact TEXT NOT NULL, address TEXT NOT NULL, rating INTEGER NOT NULL);");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS cocktails_bars ( cocktails_id INTEGER NOT NULL, bars_id INTEGER, price STRING NOT NULL, FOREIGN KEY(cocktails_id) REFERENCES bars(id), FOREIGN KEY(bars_id) REFERENCES cocktails(id));");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS vault_ingredients ( id INTEGER NOT NULL, name STRING NOT NULL, isThere INT NOT NULL, iconUrl STRING NOT NULL);");

    await dmap["vault_ingredients"].forEach((ingredient) async {
      await db.transaction((txn) async {
        final int id = ingredient["id"];
        final String name = ingredient["name"];
        final String iconUrl = ingredient["iconUrl"];
        print("inserting" + name);
        return await txn.rawInsert(
            "INSERT INTO vault_ingredients(id,name,isThere,iconUrl) VALUES ('$id','$name',0,'$iconUrl')");
      });
    });

    await dmap["cocktails"].forEach((cocktail) async {
      await db.transaction((txn) async {
        final int id = cocktail["id"];
        final String name = cocktail["name"];
        final String descripton = cocktail["description"];
        final String ingredients = cocktail["ingredients"];
        final String recipe = cocktail["recipe"];
        return await txn.rawInsert(
            "INSERT INTO cocktails(id,name,description,ingredients,recipe) VALUES ('$id','$name','$descripton','$ingredients','$recipe')");
      });
    });
    await dmap["bars"].forEach((bar) async {
      await db.transaction((txn) async {
        final int id = bar["id"];
        final String name = bar["name"];
        final String descripton = bar["description"];
        final String contact = bar["contact"];
        String address = bar["address"];
        final int rating = bar["rating"];
        await txn.rawInsert(
            "INSERT INTO bars(id,name,description,contact,address,rating) VALUES ('$id','$name','$descripton','$contact','$address','$rating')");
      });
      await db.transaction((txn) async {
        bar["cocktails"].forEach((relatedCocktail) async {
          final int bar_id = bar["id"];
          final int cocktail_id = relatedCocktail["id"];
          final String price = relatedCocktail["price"];
          return await txn.rawInsert(
              "INSERT INTO cocktails_bars(cocktails_id,bars_id,price) VALUES ('$cocktail_id','$bar_id','$price')");
        });
      });
    });
    print("Created tables");
  }

  Future<List<DrinkData>> getAllDrinks() async {
    var dbClient = await db;
    List<DrinkData> list = [];
    List<Map> rawList = await dbClient!.rawQuery('SELECT * FROM cocktails');
    if (rawList != null) {
      rawList.forEach((cocktail) {
        list.add(DrinkData.fromBackend(
          cocktail["name"],
          cocktail["description"],
          cocktail["ingredients"],
          cocktail["recipe"],
          cocktail["id"],
        ));
      });
    }
    return list;
  }

  Future<List<BarInfo>> getAllBars() async {
    var dbClient = await db;
    List<BarInfo> list = [];
    List<Map> rawList = await dbClient!.rawQuery('SELECT * FROM bars');
    if (rawList != null) {
      rawList.forEach((bar) {
        list.add(BarInfo.fromBackendWithoutMenu(bar["name"], bar["description"],
            bar["address"], bar["rating"], bar["contact"], bar["id"]));
      });
    }
    return list;
  }

  Future<List<menu.MenuItem>> getMenuItemsWithBarId(int _barID) async {
    var dbClient = await db;
    List<Map> rawList = await dbClient!
        .rawQuery('SELECT * FROM cocktails_bars WHERE bars_id = $_barID ');
    List<menu.MenuItem> cocktailsMenu = [];
    bool listPopulated = false;
    int count = 0;
    if (rawList != null) {
      for (var element in rawList) {
        final cocktail_id = element["cocktails_id"];
        final price = element["price"];
        DrinkData currentCocktail = await getCocktailById(cocktail_id);
        print(currentCocktail.getName() + " " + price);
        cocktailsMenu.add(menu.MenuItem(currentCocktail, price));
        if (count == rawList.length - 1) {
          listPopulated = true;
        }
      }
    }
    return cocktailsMenu;
  }

  Future<DrinkData> getCocktailById(int _cocktailID) async {
    var dbClient = await db;
    List<DrinkData> list = [];
    List<Map> rawList = await dbClient!
        .rawQuery("SELECT * FROM cocktails WHERE id = $_cocktailID");
    if (rawList != null) {
      rawList.forEach((cocktail) {
        list.add(DrinkData.fromBackend(
            cocktail["name"],
            cocktail["description"],
            cocktail["ingredients"],
            cocktail["recipe"],
            cocktail["id"]));
      });
    }
    return list[0];
  }

  Future<BarInfo> getBarById(int _barID) async {
    var dbClient = await db;
    List<BarInfo> list = [];
    List<Map> rawList =
        await dbClient!.rawQuery("SELECT * FROM bars WHERE id = $_barID");
    if (rawList != null) {
      rawList.forEach((bar) {
        list.add(BarInfo.fromBackendWithoutMenu(bar["name"], bar["description"],
            bar["address"], bar["rating"], bar["contact"], bar["id"]));
      });
    }
    return list[0];
  }

  Future<List<BarInfo>> getAllBarsWithDrinksIds(List<DrinkData> drinks) async {
    var dbClient = await db;
    String requestedIds = '';
    List<int> idsOfBarsAlreadyLoaded = [];
    List<BarInfo> resultingBars = [];
    for (var drink in drinks) {
      requestedIds += (drink.id.toString() + ',');
    }
    requestedIds = requestedIds.substring(0, requestedIds.length - 1);
    List<Map> rawList = await dbClient!.rawQuery(
        'SELECT * FROM cocktails_bars WHERE cocktails_id IN (' +
            requestedIds +
            ')');
    for (var element in rawList) {
      final bar_id = element["bars_id"];
      if (!idsOfBarsAlreadyLoaded.contains(bar_id)) {
        BarInfo currentBar = await getBarById(bar_id);
        resultingBars.add(currentBar);
        idsOfBarsAlreadyLoaded.add(bar_id);
      }
    }
    return resultingBars;
  }

  Future<List<VaultIngredientData>> getAllIngredients() async {
    var dbClient = await db;
    List<VaultIngredientData> list = [];
    List<Map> rawList =
        await dbClient!.rawQuery("SELECT * FROM vault_ingredients");
    if (rawList != null) {
      rawList.forEach((ing) {
        list.add(VaultIngredientData(
            id: ing["id"],
            name: ing["name"],
            status: ing["isThere"] == 0 ? false : true,
            iconUrl: ing["iconUrl"]));
      });
    }
    return list;
  }

  void saveAllIngredients(List<VaultIngredientData> newData) async {
    var dbClient = await db;
    await dbClient!.rawQuery("DELETE FROM vault_ingredients");
    newData.forEach((element) async {
      await dbClient.transaction((txn) async {
        final int id = element.id;
        final String name = element.name;
        final int isThere = element.status ? 1 : 0;
        final String iconUrl = element.iconUrl;
        print("inserting" + name);
        return await txn.rawInsert(
            "INSERT INTO vault_ingredients(id,name,isThere,iconUrl) VALUES ('$id','$name','$isThere','$iconUrl')");
      });
    });
  }
}
