import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as htp;
import 'package:provider/provider.dart';
import 'package:vegetables/constants.dart';
import 'package:vegetables/model/product.dart';
import 'package:vegetables/provider/products.dart';

class ProductsProvider extends ChangeNotifier {
  Future<void> fetchProducts(BuildContext context) async {
    final list = Provider.of<Products>(context);
    final url =
        Uri.parse('https://shareittofriends.com/demo/flutter/productList.php');

    try {
      var response = await htp.post(url, body: {
        'user_login_token': userToken,
      });
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        list.addFetchedData(responseBody);
      } else {
        showtoast('Something wrong', Colors.red);
        print('err body $responseBody');
      }
    } catch (e) {
      showtoast(e.toString(), Colors.red);
      print('erwr $e');
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        Uri.parse('https://shareittofriends.com/demo/flutter/addProduct.php');
    try {
      var response = await htp.post(url, body: {
        'user_login_token': userToken,
        'name': product.name,
        'moq': product.moq,
        'price': '${product.price}',
        'discounted_price': '${product.discountedPrice}',
      });
      var responseBody = jsonDecode(response.body);
      print('responsse $responseBody');
      if (response.statusCode == 200) {
        showtoast(responseBody['message'], Colors.green);
        print('added to api');
      } else {
        showtoast(responseBody['message'], Colors.red);
        print('eror');
      }
    } catch (e) {
      showtoast('Something wrong', Colors.red);
      print('e $e');
    }
  }

  Future<void> editProduct(int id, Product product) async {
    final url =
        Uri.parse('https://shareittofriends.com/demo/flutter/editProduct.php');
    try {
      var response = await htp.post(url, body: {
        'user_login_token': userToken,
        'id': '$id',
        'name': product.name,
        'moq': product.moq,
        'price': '${product.price}',
        'discounted_price': '${product.discountedPrice}',
      });
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showtoast(responseBody['message'], Colors.green);
      } else {
        showtoast(responseBody['message'], Colors.red);
      }
    } catch (e) {
      print('edit error $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    final url = Uri.parse(
        'https://shareittofriends.com/demo/flutter/deleteProduct.php');
    try {
      var response = await htp.post(url, body: {
        'user_login_token': userToken,
        'id': '$id',
      });
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showtoast(responseBody['message'], Colors.green);
      } else {
        print('delete err ${responseBody['message']}');
        showtoast(responseBody['message'], Colors.red);
      }
    } catch (e) {
      print('$e');
    }
  }
}
