import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vegetables/constants.dart';
import 'package:vegetables/provider/products_provider.dart';
import 'package:vegetables/screens/products_details_screen.dart';
import 'package:vegetables/widgets/side_drawer.dart';

import '../provider/products.dart';

class ProductOverviewScreen extends StatelessWidget {
  static const routeName = '/product-overview-screen';

  ProductOverviewScreen({super.key});

  ScrollController scrollController = ScrollController();

  List<String> vegList1 = [
    'Cabbage and lettuce(14)',
    'Cucumber and tomato(7)',
  ];
  List<String> vegList2 = [
    'Onions and garlic(8)',
    'Peppers(7)',
    'Potatoes and capsicum(5)'
  ];
  var selectedIndex = 0;

  ProductsProvider productsProvider = ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final fetchedList = Provider.of<Products>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      drawer: SideDrawer(),
      backgroundColor: const Color(0xffF5F5F5),
      body: FutureBuilder(
          future: productsProvider.fetchProducts(context),
          builder: (context, snapshot) {
            return Stack(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/bg.png',
                    height: 220,
                  ),
                ),
                SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 18,
                          bottom: 30,
                        ),
                        child: Text(
                          'Vegetables',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2D0C57)),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.blue[200]!)),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.search,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Search',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 21),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return SizedBox(
                          height: 40,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: vegList1.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: selectedIndex == index
                                          ? const Color(0xffE2CBFC)
                                          : Colors.white),
                                  child: Row(
                                    children: [
                                      selectedIndex == index
                                          ? const Icon(
                                              Icons.check,
                                              color: Color(0xff7A24E7),
                                              size: 25,
                                            )
                                          : Container(),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        vegList1[index],
                                        style: GoogleFonts.poppins(
                                            // fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: selectedIndex == index
                                                ? const Color(0xff7A24E7)
                                                : Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return SizedBox(
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: vegList2.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: selectedIndex == index
                                          ? const Color(0xffE2CBFC)
                                          : Colors.white),
                                  child: Row(
                                    children: [
                                      selectedIndex == index
                                          ? const Icon(
                                              Icons.check,
                                              color: Color(0xff7A24E7),
                                              size: 25,
                                            )
                                          : Container(),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        vegList2[index],
                                        style: GoogleFonts.poppins(
                                            // fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: selectedIndex == index
                                                ? const Color(0xff7A24E7)
                                                : Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      SizedBox(
                        // width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: fetchedList.overViewProduct.length,
                            itemBuilder: (context, index) {
                              var prod = fetchedList.overViewProduct[index];
                              return Container(
                                height: 130,
                                // color: Colors.amber,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            ProductsDetailsScreen.routeName);
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/img1.png')),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          prod.name,
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
                                                text: prod.moq,
                                                style: GoogleFonts.roboto(
                                                  color: textColor,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: [
                                              const TextSpan(
                                                  text: ' ₺ / piece',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 18))
                                            ])),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xff0ECE82)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.white),
                                              child: const Icon(
                                                Icons.favorite_border,
                                                color: Colors.black38,
                                                size: 22,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xff0ECE82)),
                                              child: const Icon(
                                                CupertinoIcons.cart,
                                                color: Colors.white,
                                                size: 22,
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
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
