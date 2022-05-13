import 'package:flutter/material.dart';
import 'package:cocktail_recommender/diy/diy_router.dart';
import 'package:cocktail_recommender/diy/main/main_recipie_list.dart';
import 'package:cocktail_recommender/diy/main/main_search_field.dart';
import 'package:provider/provider.dart';

class DiyPage extends StatelessWidget {
  const DiyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DiyRecipieQuery(),
      child: const MaterialApp(
        // home: DiyMain(),
        initialRoute: '/',
        onGenerateRoute: DiyRouter.generateRoute,
      ),
    );
  }
}

class DiyMainPage extends StatefulWidget {
  const DiyMainPage({Key? key}) : super(key: key);

  @override
  State<DiyMainPage> createState() => _DiyMainPageState();
}

class _DiyMainPageState extends State<DiyMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Recommender - DIY'),
      ),
      body: Container(
        color: const Color(0xffC4DFCB),
        child: Column(
          children: <Widget>[
            const SearchField(),
            Expanded(child: RecipieList()),
          ],
        ),
      ),
    );
  }
}

class DiyRecipieQuery extends ChangeNotifier {
  String _query = '';

  String get query => _query;

  void updateQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }
}
