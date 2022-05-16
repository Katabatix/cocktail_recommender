import 'package:flutter/material.dart';

import '../utils/drink_data.dart';

class MenuItem {
  DrinkData drink;
  String price;

  MenuInfo(this.drink, this.price);
}

class MenuDetails extends StatelessWidget {
  const MenuDetails({Key? key}) : super(key: key);

  static const routeName = '/discover/menudetails';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MenuItem;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu', style: TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: args.drinks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(args.drinks[index].name),
            subtitle: Text(args.prices.firstWhere((price) => (price.id == args.drinks[index].id)).price),
            // trailing: ,
          );
        }
      ),
    );
  }
}
