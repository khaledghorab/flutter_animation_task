import 'package:flutter/cupertino.dart';

class Product {
  final String? id;
  final String? title;
  final String? color;
  final String? price;
  final String? totalPrice;
  final String? imageUrl;

  Product({
    @required this.id,
    @required this.title,
    @required this.color,
    @required this.price,
    @required this.totalPrice,
    @required this.imageUrl,
  });
}
