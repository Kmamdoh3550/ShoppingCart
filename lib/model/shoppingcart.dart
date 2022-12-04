class ShoppingCart {
  final String itemcode;
  final String itemdescription;
  int quantity;
  double price;
  final String image;
  double total;

  ShoppingCart(
      {required this.itemcode,
      required this.itemdescription,
      required this.quantity,
      required this.price,
      required this.image,
      required this.total});
}
