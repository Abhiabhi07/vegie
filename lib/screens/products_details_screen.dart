import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants.dart';

class ProductsDetailsScreen extends StatelessWidget {
  static const routeName = '/prodcuts-details-screen';
  ProductsDetailsScreen({super.key});

  var controller = PageController();

  List<String> images = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: PageView.builder(
                      controller: controller,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        );
                      }),
                ),
                Positioned(
                  bottom: 20,
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: images.length,
                    effect: WormEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10),
                  ),
                )
              ],
            ),
            Positioned(
              top: 290,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Boston Lettuce',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff2D0C57)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                            text: '1.10',
                            style: GoogleFonts.roboto(
                              color: textColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                          const TextSpan(
                              text: ' ₺ / piece',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400))
                        ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '~ 150 gr / piece',
                        style: GoogleFonts.poppins(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Spain',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff2D0C57)),
                      ),
                    ),
                    Flexible(
                        child: Text(
                      textAlign: TextAlign.left,
                      'Lettuce is an annual plant of the family Asteraceae. It is most often grown as a leaf vegetable, but sometimes for its stem and seeds. Lettuce is most often used for salads, although it is also seen in other kinds of food, such as soups, sandwiches and wraps; it can also be grilled.',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xff9685A7),
                          fontWeight: FontWeight.w500),
                    )),
                    const SizedBox(
                      height: 65,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: 75,
                          margin: const EdgeInsets.only(
                            right: 20,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.black38,
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(0, 55),
                                backgroundColor: const Color(0xff0ECE82),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            onPressed: () {},
                            label: Text(
                              ' ADD TO CART',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            icon: const Icon(
                              CupertinoIcons.cart,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
