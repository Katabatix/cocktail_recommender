import 'package:flutter/material.dart';
import 'package:cocktail_recommender/diy/vault/vault_ingredient_list.dart';
import 'package:provider/provider.dart';

class DiyVaultPage extends StatefulWidget {
  const DiyVaultPage({Key? key}) : super(key: key);

  @override
  State<DiyVaultPage> createState() => _DiyVaultPageState();
}

class _DiyVaultPageState extends State<DiyVaultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vault'),
      ),
      body: ChangeNotifierProvider(
          create: (context) => VaultIngredientQuery(),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: const [
                IngredientSearchField(),
                VaultIngredientList(),
              ],
            ),
          )),
    );
  }
}

class VaultIngredientQuery extends ChangeNotifier {
  String _query = '';

  String get query => _query;

  void updateQuery(String newQuery) {
    debugPrint('[VaultIngredientQuery] Query Updated: $newQuery');
    _query = newQuery;
    notifyListeners();
  }
}

class IngredientSearchField extends StatelessWidget {
  const IngredientSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        color: Theme.of(context)
            .colorScheme
            .background, //onBackground.withOpacity(0.3),
        height: 50,
        child: Row(children: [
          Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(
            width: 7.5,
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.5),
                      child: Form(
                        child: TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 17.5),
                          onChanged: (value) {
                            var query = context.read<VaultIngredientQuery>();
                            query.updateQuery(value);
                            debugPrint('[Vault] query: ' + query.query);
                          },
                        ),
                      ))))
        ]));
  }
}
