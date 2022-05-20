import 'package:cocktail_recommender/discover/menu_details.dart' as m;
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';

class BarInfo {
  late String name;
  late String description;
  late String location;
  late int rating;
  late int id;
  late String contact;
  late List<m.MenuItem> menu;

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
  const BarDetails({Key? key, required this.data}) : super(key: key);

  static const routeName = '/discover/bardetails';
  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launchUrl(launchUri);
  // }

  @override
  Widget build(BuildContext context) {
    debugPrint(data.name);
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 2,
            color: Theme.of(context).colorScheme.background,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "http://10.0.2.2:3000/images/high%20quality/bars/${data.id + 1}.jpg",
                            //"http://localhost:3000/images/high%20quality/bars/${data.id + 1}.jpg",
                            height: 200,
                          ),
                        ),
                      ),
                    Text(
                      data.name,
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          data.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            //color: Colors.orange,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              data.location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // InkWell(
                    //     onTap: hasCallSupport
                    //     ? () => setState(() {
                    //           _launched = _makePhoneCall(_phone);
                    //         })
                    //     : null,
                    // child:
                    Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            //color: Colors.orange,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              data.contact,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            m.MenuDetails.routeName,
                            arguments: data.menu,
                          );
                        },
                        child: Text(
                          'See Menu',
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primary, //THEME LATER
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          runAlignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
        ),
            ),
      )),
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
