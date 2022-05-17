import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'utils/cocktail.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'discover/bar_details.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

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
    print("TRYING JSON PLEASE WORK");
    Map<String, dynamic> dmap =
        await parseJsonFromAssets('assets/test_json.json');
    print(dmap);

    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE IF NOT EXISTS cocktails (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, ingredients TEXT NOT NULL, recipe TEXT NOT NULL);");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS  bars (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, contact TEXT NOT NULL, address TEXT NOT NULL);");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS cocktails_bars ( cocktails_id INTEGER, bars_id INTEGER, price INTEGER, FOREIGN KEY(cocktails_id) REFERENCES bars(id), FOREIGN KEY(bars_id) REFERENCES cocktails(id));");

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
        await txn.rawInsert(
            "INSERT INTO bars(id,name,description,contact,address) VALUES ('$id','$name','$descripton','$contact','$address')");
      });
      await db.transaction((txn) async {
        bar["cocktails"].forEach((relatedCocktail) async {
          final int bar_id = bar["id"];
          final int cocktail_id = relatedCocktail["id"];
          final int price = relatedCocktail["price"];
          return await txn.rawInsert(
              "INSERT INTO cocktails_bars(cocktails_id,bars_id,price) VALUES ('$cocktail_id','$bar_id','$price')");
        });
      });
    });
    print("Created tables");
  }

  Future<List<Cocktail>> getAllDrinks() async {
    var dbClient = await db;
    List<Cocktail> list = [];
    List<Map> rawList = await dbClient!.rawQuery('SELECT * FROM cocktails');
    if (rawList != null) {
      rawList.forEach((cocktail) {
        list.add(Cocktail(
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

  // Future<List<BarDetails>> getAllBars() async {
  //   var dbClient = await db;
  //   List<BarDetails> list = [];
  //   List<Map> rawList = await dbClient!.rawQuery('SELECT * FROM bars');
  //   if (rawList != null) {
  //     rawList.forEach((bar) {
  //       list.add(BarDetails(bar["name"],"temporary location",bar["address"],bar["id"],));
  //      });
  //   }
  //   // BarInfo(
  //   //   this.name, this.location, this.address, this.rating, this.id, this.menu)
  //   //bars (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, contact TEXT NOT NULL, address TEXT NOT NULL, imageURL TEXT NOT NULL);
  //   return list;
  // }
  // void testAdd() async {
  //   var dbClient = await db;
  //   await dbClient!.execute(
  //       '''INSERT INTO cocktails(id,name,description,ingredients,) VALUES ('1','random_cocktail','random_description','random_contact','address')''');
  // }
  // void saveEmployee(Employee employee) async {
  //   var dbClient = await db;
  //   await dbClient.transaction((txn) async {
  //     return await txn.rawInsert(
  //         'INSERT INTO Employee(firstname, lastname, mobileno, emailid ) VALUES(' +
  //             ''' +
  //             employee.firstName +
  //             ''' +
  //             ',' +
  //             ''' +
  //             employee.lastName +
  //             ''' +
  //             ',' +
  //             ''' +
  //             employee.mobileNo +
  //             ''' +
  //             ',' +
  //             ''' +
  //             employee.emailId +
  //             ''' +
  //             ')');
  //   });
  // }

  // Future<List<Employee>> getEmployees() async {
  //   var dbClient = await db;
  //   List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');
  //   List<Employee> employees = new List();
  //   for (int i = 0; i < list.length; i++) {
  //     employees.add(new Employee(list[i]["firstname"], list[i]["lastname"],
  //         list[i]["mobileno"], list[i]["emailid"]));
  //   }
  //   print(employees.length);
  //   return employees;
  // }
}
