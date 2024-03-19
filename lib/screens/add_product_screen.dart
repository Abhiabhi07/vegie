import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetables/model/product.dart';
import 'package:vegetables/provider/action_provider.dart';
import 'package:vegetables/provider/products.dart';
import 'package:vegetables/widgets/product_image_picker.dart';

import 'auth_screen.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product-screen';
  AddProductScreen({super.key, required this.id});
  final int id;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();

  var name;

  var moq;

  var price;

  var discount;

  var pickedImage;
  Product product = Product(
    id: 0,
    name: '',
    moq: '',
    price: 0,
    discountedPrice: 0,
  );

  var initialValue = {
    'name': '',
    'moq': '',
    'price': 0.0,
    'discountedPrice': 0.0,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != 0) {
      product = Provider.of<Products>(context, listen: false)
          .fetchProductById(widget.id);
      initialValue = {
        'name': product.name!,
        'moq': product.moq!,
        'price': product.price!,
        'discountedPrice': product.discountedPrice!,
      };
    }
  }

  void submit(BuildContext context) async {
    final productList = Provider.of<Products>(context, listen: false);
    final loading = Provider.of<ActionProvider>(context, listen: false);

    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    formKey.currentState!.save();
    productList.increaseIndexId();
    loading.isProductTrue();

    if (widget.id != 0) {
      await productList.updateProduct(
        widget.id,
        product,
      );
    } else {
      await productList.addProduct(
        productList.indexId,
        product,
      );
    }
    loading.isProductFalse();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final loading = Provider.of<ActionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          children: [
            ProductImagePicker(
              pickImage: (img) {
                pickedImage = img;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFFeild(
              initialValue: initialValue['name']! as String,
              icon: Icons.text_fields,
              title: 'Name',
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return 'name is required';
                }
                return null;
              },
              onSaved: (v) {
                product = Product(
                  id: product.id,
                  name: v!,
                  moq: product.moq,
                  price: product.price,
                  discountedPrice: product.discountedPrice,
                );
              },
              keyboardType: TextInputType.name,
            ),
            TextFFeild(
              initialValue: initialValue['moq']! as String,
              icon: Icons.post_add_rounded,
              title: 'Minimum Order Quantity',
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return 'moq is required';
                }
                return null;
              },
              onSaved: (v) {
                product = Product(
                  id: product.id,
                  name: product.name,
                  moq: v!,
                  price: product.price,
                  discountedPrice: product.discountedPrice,
                );
              },
            ),
            TextFFeild(
              initialValue: initialValue['price']!.toString(),
              icon: Icons.currency_rupee_outlined,
              title: 'Price',
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return 'price is required';
                }
                return null;
              },
              onSaved: (v) {
                product = Product(
                  id: product.id,
                  name: product.name,
                  moq: product.moq,
                  price: double.parse(v!),
                  discountedPrice: product.discountedPrice,
                );
              },
              keyboardType: TextInputType.number,
            ),
            TextFFeild(
              initialValue: initialValue['discountedPrice']!.toString(),
              icon: Icons.discount_outlined,
              title: 'Discount',
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return 'discount is required';
                }
                return null;
              },
              onSaved: (v) {
                product = Product(
                  id: product.id,
                  name: product.name,
                  moq: product.moq,
                  price: product.price,
                  discountedPrice: double.parse(v!),
                );
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize: Size(double.infinity, 60)),
                  onPressed: loading.isProductLoading
                      ? null
                      : () {
                          submit(
                            context,
                          );
                        },
                  child: loading.isProductLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Add Product',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
