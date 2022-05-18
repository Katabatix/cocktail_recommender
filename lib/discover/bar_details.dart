import 'package:cocktail_recommender/discover/menu_details.dart';
import 'package:flutter/material.dart';

class BarInfo {
  late String name;
  late String description;
  late String location;
  late int rating;
  late int id;
  late String contact;
  late List<MenuItem> menu;

  BarInfo(this.name, this.description, this.location, this.rating, this.id,
      this.contact, this.menu);

  BarInfo.fromBackendWithoutMenu(
      _name, _description, _location, _rating, _contact, _id) {
    name = _name;
    description = _description;
    location = _location;
    rating = _rating;
    id = _id;
    contact = _contact;
  }

  BarInfo.withMenu(_name, _description, _location, _rating, _id, _menuItems) {
    name = _name;
    description = _description;
    location = _location;
    rating = _rating;
    id = _id;
  }

  String getName() {
    return name;
  }

  void populateMenuItems() async {}
}

class BarDetails extends StatelessWidget {
  final BarInfo data;
  const BarDetails({Key? key, required this.data}) : super (key: key);

  static const routeName = '/discover/bardetails';

  @override
  Widget build(BuildContext context) {
    debugPrint(data.name);
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name, style: const TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network("http://10.0.2.2:3000/images/high%20quality/bars/${data.id+1}.jpg", height: 250,),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  data.name,
                  style: const TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  data.location,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    ReviewIcons(data.rating),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    //   child: TextButton(
                    //       onPressed: () {}, //Add routing to ReviewDetails
                    //       child: const Text(
                    //           'See Reviews',
                    //           style: TextStyle(
                    //             color: Colors.black, //THEME LATER
                    //             fontSize: 20,
                    //           )
                    //       )
                    //   ),
                    // ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context,
                      MenuDetails.routeName,
                      arguments: data.menu,
                  );
                },
                child: const Text(
                  'See Menu',
                  style: TextStyle(
                    color: Colors.black, //THEME LATER
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        color: Colors.white, //THEME LATER
      ),
    );
  }
}

class ReviewIcons extends StatelessWidget {
  // const ReviewIcons({Key? key}) : super(key: key);
  ReviewIcons(this.rating, {Key? key}) : super(key: key);

  final int rating;

  final children = <Widget>[];

  void _addRatingIcons() {
    children.add(const Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
    ));
    for (int i = 0; i < 5; i++) {
      children.add(Icon(
        Icons.star,
        color: (rating > i) ? Colors.yellow : Colors.grey[300],
        size: 24.0,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _addRatingIcons();
    return Row(
      children: children,
    );
  }
}
