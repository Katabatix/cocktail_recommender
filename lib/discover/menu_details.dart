import 'package:flutter/material.dart';

import '../utils/drink_data.dart';

class MenuItem {
  DrinkData drink;
  String price;

  MenuItem(this.drink, this.price);
}

class MenuDetails extends StatelessWidget {
  const MenuDetails({Key? key}) : super(key: key);

  static const routeName = '/discover/menudetails';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<MenuItem>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu', style: TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: args.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(args[index].drink.name),
            subtitle: Text(args[index].price),
            // trailing: ,
          );
        }
      ),
    );
  }
}
