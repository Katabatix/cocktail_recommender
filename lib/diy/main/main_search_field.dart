import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cocktail_recommender/diy/main/diy_main.dart';
import 'package:cocktail_recommender/utils/global_vars.dart' as global;
import 'main_recipie_list.dart';
import 'dart:async';

class SearchField extends StatelessWidget {
  SearchField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(child: RecipieSearchBar()),
          SizedBox(
            width: 10,
          ),
          ButtonVault(),
        ],
      ),
    );
  }
}

class RecipieSearchBar extends StatelessWidget {
  const RecipieSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
        child: Form(
          child: TextFormField(
            onChanged: (value) {
              var query = context.read<DiyRecipieQuery>();
              query.updateQuery([value]);
              debugPrint('[Recipie Mian] query: ' + query.query[0]);
            },
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ));
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
    global.navigatorKey.currentState?.pushNamed('/diy/vault');
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
