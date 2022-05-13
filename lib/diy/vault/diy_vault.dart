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
        child: Column(
          children: const [
            IngredientSearchField(),
            VaultIngredientList(),
          ],
        ),
      ),
    );
  }
}

class VaultIngredientQuery extends ChangeNotifier {
  String _query = '';

  String get query => _query;

  void updateQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }
}

class IngredientSearchField extends StatelessWidget {
  const IngredientSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: (value) {
          var query = context.read<VaultIngredientQuery>();
          query.updateQuery(value);
          debugPrint('[Vault] query: ' + query.query);
        },
      ),
    );
  }
}
