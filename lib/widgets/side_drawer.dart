import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegetables/screens/auth_screen.dart';
import 'package:vegetables/screens/user_product_screen.dart';

import '../constants.dart';
import '../screens/btm_nav_screen.dart';

class SideDrawer extends StatefulWidget {
  SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  List<Map<String, dynamic>> menuItems = [
    {
      'icon': CupertinoIcons.shopping_cart,
      'title': 'Shop',
      'routeName': BottomNavScreen.routeName,
    },
    {
      'icon': CupertinoIcons.add,
      'title': 'Your Products',
      'routeName': UserProductScreen.routeName,
    },
  ];

  var selectedIndex;

  Color statusColor(int index) {
    var color = selectedPage == index ? Colors.white : Colors.black;

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.68,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
          color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 18),
            child: Row(
              children: [
                const Icon(Icons.menu_outlined),
                // Image.asset('assets/images/menu.png'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Menu',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
              shrinkWrap: true,
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedPage = index;
                    });
                    Navigator.pushReplacementNamed(
                        context, menuItems[index]['routeName'],
                        arguments: menuItems[index]['arguments']);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 12, 15, 12),
                    margin: const EdgeInsets.only(right: 25, bottom: 10),
                    decoration: BoxDecoration(
                        color: selectedPage == index ? Colors.green : null,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          menuItems[index]['icon'],
                          color: statusColor(index),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          menuItems[index]['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: statusColor(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          const Spacer(),
          TextButton.icon(
            style: TextButton.styleFrom(
                padding: EdgeInsets.only(left: 18),
                animationDuration: Duration.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                alignment: Alignment.centerLeft,
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                // backgroundColor: Colors.amber,
                elevation: 0.0),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                AuthScreen.routeName,
              );
            },
            label: const Text(
              'LOG OUT',
              style: TextStyle(color: Colors.red),
            ),
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
