import 'package:flutter/material.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';

import '../utils/drink_data.dart';

class MenuItem {
  DrinkData drink;
  String price;

  MenuItem(this.drink, this.price);
}

class MenuDetails extends StatelessWidget {
  final List<MenuItem> data;
  const MenuDetails({Key? key, required this.data}) : super(key: key);

  static const routeName = '/discover/menudetails';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(data[index].drink.name),
            subtitle: Text(data[index].price),
            // trailing: ,
          );
        }
      ),
    );
  }
}
