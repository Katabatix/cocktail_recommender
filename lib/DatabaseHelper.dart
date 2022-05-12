import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;
  static Future<List>? test;

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
        "CREATE TABLE IF NOT EXISTS cocktails (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, ingredients TEXT NOT NULL);");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS  bars (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, contact TEXT NOT NULL, address TEXT NOT NULL);");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS cocktails_bars ( cocktails_id INTEGER, bars_id INTEGER, FOREIGN KEY(cocktails_id) REFERENCES bars(id), FOREIGN KEY(bars_id) REFERENCES cocktails(id));");
    await db.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO cocktails(id,name,description,ingredients) VALUES ('1','random_cocktail','random_description','random_ingredients')");
    });
    print("Created tables");
  }

  Future<List> testing() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM cocktails');
    if (list != null) {
      return list;
    } else {
      List empty = List.generate(1, (index) => index);
      return empty;
    }
  }

  void testAdd() async {
    var dbClient = await db;
    await dbClient!.execute(
        '''INSERT INTO cocktails(id,name,description,ingredients,) VALUES ('1','random_cocktail','random_description','random_contact','address')''');
  }
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
