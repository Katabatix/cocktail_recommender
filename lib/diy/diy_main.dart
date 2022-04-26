import 'package:flutter/material.dart';

class DiyMain extends StatelessWidget {
  const DiyMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail Recommender - DIY'),
      ),
      body: Container(
        color: const Color(0xffC4DFCB),
        child: const Center(
          child: SearchField(),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

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
    return Autocomplete(optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text == '') {
        return const Iterable<String>.empty();
      }
      return _searchAutoCompleteOptions.where((String option) {
        return option.contains(textEditingValue.text.toLowerCase());
      });
    }, onSelected: (String selection) {
      debugPrint('You just selected: $selection');
    });
  }
}
