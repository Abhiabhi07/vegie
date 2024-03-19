import 'package:flutter/material.dart';
import 'package:vegetables/model/product.dart';
import 'package:vegetables/provider/products_provider.dart';

class Products extends ChangeNotifier {
  ProductsProvider productsProvider = ProductsProvider();

  List<Product> overViewProduct = [];

  void addFetchedData(List<dynamic> fetchedData) {
    overViewProduct = fetchedData.map((e) => Product.fromMap(e)).toList();
    notifyListeners();
  }

  List<Product> products = [];
  var indexId = 0;

  void increaseIndexId() {
    indexId++;

    notifyListeners();
  }

  Product fetchProductById(int id) {
    final product = products.firstWhere((element) => element.id == id);
    return product;
  }

  Future<void> addProduct(int id, Product product) async {
    final newProd = Product(
      id: id,
      name: product.name,
      moq: product.moq,
      price: product.price,
      discountedPrice: product.discountedPrice,
    );
    products.add(newProd);
    await productsProvider.addProduct(newProd);
    notifyListeners();
  }

  Future<void> updateProduct(int id, Product newProduct) async {
    final prodIndex = products.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      products[prodIndex] = newProduct;
      await productsProvider.editProduct(id, newProduct);
      notifyListeners();
    }
  }

  Future<void> deleteImage(int id) async {
    products.removeWhere((element) => element.id == id);
    await productsProvider.deleteProduct(id);
    notifyListeners();
  }
}
