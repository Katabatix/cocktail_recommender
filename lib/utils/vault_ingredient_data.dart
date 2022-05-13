class VaultIngredientData {
  final String name;
  final int id;
  bool status;
  final String iconUrl;

  VaultIngredientData(
      {this.name = 'Sample Ingredient',
      required this.id,
      this.status = false,
      this.iconUrl =
          'https://upload.wikimedia.org/wikipedia/commons/8/80/15-09-26-RalfR-WLC-0084.jpg'});

  @override
  String toString() {
    return 'id: ' +
        id.toString() +
        ', name: ' +
        name +
        ', status: ' +
        status.toString();
  }
}
