import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetables/provider/action_provider.dart';
import 'package:vegetables/screens/product_overview_screen.dart';

class BottomNavScreen extends StatelessWidget {
  static const routeName = '/bottom-nav-screen';
  BottomNavScreen({super.key});

  List<Widget> screens = [
    ProductOverviewScreen(),
    const Scaffold(
      body: Center(
        child: Text('Cart Page'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Profile Page'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final indexValue = Provider.of<ActionProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexValue.index,
        onTap: (ind) {
          indexValue.incrementIndex(ind);
        },
        selectedItemColor: Colors.purple,
        items: const [
          BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard)),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(CupertinoIcons.cart),
              activeIcon: Icon(CupertinoIcons.cart_fill)),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(CupertinoIcons.person),
              activeIcon: Icon(CupertinoIcons.person_fill))
        ],
      ),
      body: screens.elementAt(indexValue.index),
    );
  }
}
