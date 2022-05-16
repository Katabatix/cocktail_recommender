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

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE IF NOT EXISTS cocktails (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, ingredients TEXT NOT NULL, recipe TEXT NOT NULL, imageURL TEXT NOT NULL);");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS  bars (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, contact TEXT NOT NULL, address TEXT NOT NULL, imageURL TEXT NOT NULL);");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS cocktails_bars ( cocktails_id INTEGER, bars_id INTEGER, price INTEGER, FOREIGN KEY(cocktails_id) REFERENCES bars(id), FOREIGN KEY(bars_id) REFERENCES cocktails(id));");

    io.File f = new io.File('./assets/csv/drinks.csv');
    print("CSV to List");
    final input = f.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();
    print(fields);

    var counter = 1;
    fields.forEach((element) async {
      await db.transaction((txn) async {
        final String name = element[0];
        final String descripton = element[1];
        final String ingredients = element[2];
        final String imageURL = element[3];
        final String recipe = element[4];
        return await txn.rawInsert(
            "INSERT INTO cocktails(id,name,description,ingredients,recipe,imageURL) VALUES ('$counter','$name','$descripton','$ingredients','$recipe','$imageURL)");
      });
      counter += 1;
    });

    io.File f2 = new io.File('./assets/csv/bars.csv');
    print("CSV to List");
    final input2 = f2.openRead();
    final fields2 = await input2
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();
    print(fields2);
    counter = 1;
    fields2.forEach((element) async {
      await db.transaction((txn) async {
        final String name = element[0];
        final String descripton = element[1];
        final String contact = element[2];
        String address = element[3];
        address = address.replaceAll('*', ',');
        final String imageURL = element[7];
        return await txn.rawInsert(
            "INSERT INTO bars(id,name,description,contact,address,imageURL) VALUES ('$counter','$name','$descripton','$contact','$address','$imageURL)");
      });

      final String drinksIds = element[5];
      final String drinksPrices = element[6];
      final List<String> drinkIdsSplit = drinksIds.split(' ');
      final List<String> drinkPricesSplit = drinksPrices.split(' ');
      if (drinkIdsSplit.length != drinkPricesSplit) {
        print("improper data for bar id $counter");
      }
      for (int i = 0; i < drinkIdsSplit.length; ++i) {
        await db.transaction((txn) async {
          final int bar_id = counter;
          final int cocktail_id = int.parse(drinkIdsSplit[i]);
          final int price = int.parse(drinkPricesSplit[i]);
          return await txn.rawInsert(
              "INSERT INTO cocktails_bars(cocktails_id,bars_id,price) VALUES ('$cocktail_id','$bar_id','$price'");
        });
      }
      counter += 1;
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
