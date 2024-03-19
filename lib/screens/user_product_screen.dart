import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vegetables/provider/products.dart';
import 'package:vegetables/screens/add_product_screen.dart';
import 'package:vegetables/widgets/side_drawer.dart';

import '../constants.dart';
import 'products_details_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';
  UserProductScreen({super.key});
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<Products>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AddProductScreen.routeName, arguments: {'id': 0});
        },
        backgroundColor: Colors.green,
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('Your Products'),
      ),
      body: productList.products.isEmpty
          ? Center(
              child: Text('You dont have any products'),
            )
          : ListView.builder(
              itemCount: productList.products.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final product = productList.products[index];
                return Container(
                  height: 130,
                  // color: Colors.amber,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProductsDetailsScreen.routeName);
                        },
                        child: Container(
                          height: double.infinity,
                          width: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: product.image != null
                                    ? FileImage(product.image!)
                                        as ImageProvider<Object>
                                    : AssetImage('assets/images/img1.png')),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            product.name!,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: textColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          RichText(
                            text: TextSpan(
                                text: '${product.discountedPrice}',
                                style: GoogleFonts.roboto(
                                  color: textColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: const [
                                  TextSpan(
                                      text: ' ₺ / piece',
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 18))
                                ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              StatefulBuilder(builder: (context, sState) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Text(
                                              'Are you sure you want to delete this item?',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'Cancle',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )),
                                              TextButton(
                                                  onPressed: isLoading
                                                      ? null
                                                      : () async {
                                                          sState(() {
                                                            isLoading = true;
                                                          });
                                                          await productList
                                                              .deleteImage(
                                                                  product.id!);
                                                          sState(() {
                                                            isLoading = false;
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                  child: isLoading
                                                      ? CircularProgressIndicator()
                                                      : Text(
                                                          'Delete',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ))
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff0ECE82)),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.white),
                                    child: const Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.black38,
                                      size: 22,
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('pid ${product.id}');
                                  Navigator.of(context).pushNamed(
                                    AddProductScreen.routeName,
                                    arguments: {'id': product.id},
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color(0xff0ECE82)),
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
