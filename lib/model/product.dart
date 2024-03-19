import 'dart:io';

class Product {
  final int? id;
  final File? image;
  final String name;
  final String moq;
  final double price;
  final double discountedPrice;

  Product({
    this.image,
    required this.id,
    required this.name,
    required this.moq,
    required this.price,
    required this.discountedPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'id': id,
      'name': name,
      'moq': moq,
      'price': price,
      'discountedPrice': discountedPrice,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: int.parse(map['id']),
      name: map['name'],
      moq: map['moq'],
      price: double.parse(map['price']),
      discountedPrice: double.parse(map['discounted_price']),
    );
  }
}
