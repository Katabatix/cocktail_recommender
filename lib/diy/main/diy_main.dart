import 'package:flutter/material.dart';
import 'package:cocktail_recommender/diy/main/main_recipie_list.dart';
import 'package:cocktail_recommender/diy/main/main_search_field.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_recommender/main.dart';

class DiyPage extends StatelessWidget {
  const DiyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DiyRecipieQuery(),
      child: const Scaffold(
        body: DiyMainPage(),
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
    WidgetsBinding.instance!.addPostFrameCallback((_) => _afterBuild(context));
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

  void _afterBuild(BuildContext context) {
    var navBarIndex = context.read<NavBarIndex>();
    navBarIndex.updateIndex(1);
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
