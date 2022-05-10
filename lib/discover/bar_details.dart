import 'package:cocktail_recommender/discover/menu_details.dart';
import 'package:flutter/material.dart';

class BarInfo {
  String name;
  String location;
  int rating;
  int id;
  MenuInfo menu;

  BarInfo(this.name, this.location, this.rating, this.id, this.menu);
}

class BarDetails extends StatelessWidget {
  const BarDetails({Key? key}) : super (key: key);

  static const routeName = '/discover/bardetails';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BarInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/images/bar0.jpg'),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                args.name,
                style: const TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  ReviewIcons(args.rating),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: TextButton(
                      onPressed: () {}, //TODO: Add routing to ReviewDetails
                      child: const Text(
                        'See Reviews',
                        style: TextStyle(
                          fontSize: 20,
                        )
                      )
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                args.location,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child:TextButton(
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    MenuDetails.routeName,
                    arguments: args.menu,
                );
              },
              child: const Text('See Menu',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}

class ReviewIcons extends StatelessWidget {
  // const ReviewIcons({Key? key}) : super(key: key);
  ReviewIcons(this.rating);

  final rating;

  final children = <Widget>[];

  void _addRatingIcons() {
    children.add(const Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
    ));
    for(int i = 0; i < 5; i++){
      children.add(Icon(
        Icons.star,
        color: (rating > i)? Colors.yellow: Colors.grey[300],
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
