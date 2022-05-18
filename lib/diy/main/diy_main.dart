import 'package:flutter/material.dart';
import 'package:cocktail_recommender/diy/main/main_recipie_list.dart';
import 'package:cocktail_recommender/diy/main/main_search_field.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_recommender/main.dart';
import 'package:cocktail_recommender/utils/drink_data.dart';

class DiyPage extends StatelessWidget {
  final List<DrinkData> drinkList;
  bool updateBottomNavBar;
  DiyPage({
    Key? key,
    List<DrinkData>? drinkList,
    this.updateBottomNavBar = false,
  })  : drinkList = drinkList ?? <DrinkData>[],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('DiyPage Builded');
    return ChangeNotifierProvider(
      create: (context) => DiyRecipieQuery(),
      child: Scaffold(
        body: DiyMainPage(
          drinkList: drinkList,
          updateBottomNavBar: updateBottomNavBar,
        ),
      ),
    );
  }
}

class DiyMainPage extends StatefulWidget {
  final List<DrinkData> drinkList;
  bool updateBottomNavBar;
  DiyMainPage({
    Key? key,
    List<DrinkData>? drinkList,
    this.updateBottomNavBar = false,
  })  : drinkList = drinkList ?? <DrinkData>[],
        super(key: key);

  @override
  State<DiyMainPage> createState() => _DiyMainPageState();
}

class _DiyMainPageState extends State<DiyMainPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.updateBottomNavBar) {
      WidgetsBinding.instance!
          .addPostFrameCallback((_) => _afterBuild(context));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Recommender - DIY'),
      ),
      body: Container(
        color: const Color(0xffC4DFCB),
        child: Column(
          children: <Widget>[
            const SearchField(),
            Expanded(child: RecipieList(drinkList: widget.drinkList)),
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
    debugPrint('[DiyRecipieQuery] Query Updated: $newQuery');
    _query = newQuery;
    notifyListeners();
  }
}
