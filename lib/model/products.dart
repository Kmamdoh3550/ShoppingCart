import 'package:flutter/cupertino.dart';

class Products {
  final String code;
  final String name;
  final String price;
  final String images;
  final String color;
  final String colortext;
  final int quantity;
  final double pricevalue;
  final List gallery;

  Products(
      {required this.code,
      required this.name,
      required this.price,
      required this.images,
      required this.color,
      required this.colortext,
      required this.quantity,
      required this.pricevalue,
      required this.gallery});
}
