import 'package:flutter/material.dart';

class MenuInfo {
  List<MenuItem> menu;

  MenuInfo(this.menu);
}

class MenuItem {
  String itemName;
  String price;

  MenuItem(this.itemName, this.price);
}

class MenuDetails extends StatelessWidget {
  const MenuDetails({Key? key}) : super(key: key);

  static const routeName = '/discover/menudetails';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MenuInfo;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: args.menu.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(args.menu[index].itemName),
            subtitle: Text(args.menu[index].price),
          );
        }
      ),
    );
  }
}