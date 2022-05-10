import 'package:flutter/material.dart';
import 'package:cocktail_recommender/diy/diy_router.dart';
import 'package:cocktail_recommender/utils/recipie_data.dart';

class DiyPage extends StatelessWidget {
  const DiyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: DiyMain(),
      initialRoute: '/',
      onGenerateRoute: DiyRouter.generateRoute,
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

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: const <Widget>[
          Expanded(child: RecipieSearchBar()),
          ButtonVault(),
        ],
      ),
    );
  }
}

class RecipieSearchBar extends StatelessWidget {
  const RecipieSearchBar({Key? key}) : super(key: key);

  static const List<String> _searchAutoCompleteOptions = <String>[
    'Vodka',
    'Gin',
    'Rum',
    'Tequila',
    'Cola',
    'Whiskey',
    'Lime',
    'Beer',
    'Orange Peel',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _searchAutoCompleteOptions.where((String option) {
          String lowOption = option.toLowerCase();
          return lowOption.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected: $selection');
      },
    );
  }
}

class ButtonVault extends StatefulWidget {
  const ButtonVault({Key? key}) : super(key: key);

  @override
  State<ButtonVault> createState() => _ButtonVaultState();
}

class _ButtonVaultState extends State<ButtonVault> {
  void routeToVault() {
    debugPrint('[Button Vault] Routing to vault');
    Navigator.of(context).pushNamed(
      '/vault',
      arguments: 'This is from Button Vault',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(color: Colors.blueGrey),
            ),
          ),
          TextButton(
            child: const Icon(Icons.cabin),
            onPressed: routeToVault,
          ),
        ],
      ),
    );
  }
}

class RecipieList extends StatefulWidget {
  RecipieList({Key? key}) : super(key: key);

  @override
  State<RecipieList> createState() => _RecipieListState();
}

class _RecipieListState extends State<RecipieList> {
  int tempLength = 30;

  List<Widget> constructList() {
    List<Widget> outputList = [];
    for (int i = 0; i < tempLength; i++) {
      String name = 'Sample Drink ' + i.toString();
      outputList.add(RecipieListItem(data: RecipieData(name: name)));
    }
    return outputList;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            constructList(),
          ),
        ),
      ],
    );
  }

  // Widget build(BuildContext context) {
  //   return ListView(
  //     padding: const EdgeInsets.all(8),
  //     children: constructList(),
  //   );
  // }
}

// class RecipieListItemData {
//   final String recipieName;
//   final List<String> recipieIngredients;
//   final String iconURL;

//   const RecipieListItemData({
//     this.recipieName = 'Sample Drink',
//     this.recipieIngredients = const ['a', 'b', 'c'],
//     this.iconURL =
//         'https://cdn.icon-icons.com/icons2/2596/PNG/512/check_one_icon_155665.png',
//   });
// }

class RecipieListItem extends StatelessWidget {
  final RecipieData data;

  const RecipieListItem({Key? key, this.data = const RecipieData()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).pushNamed('/recipie', arguments: data);
        },
        child: SizedBox(
          height: 70,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 8),
              Image.network(
                data.imageURL,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 8),
              Text(data.name),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipiePage extends StatelessWidget {
  const RecipiePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
