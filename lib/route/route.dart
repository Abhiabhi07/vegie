import 'package:flutter/material.dart';
import 'package:vegetables/screens/add_product_screen.dart';
import 'package:vegetables/screens/btm_nav_screen.dart';
import 'package:vegetables/screens/product_overview_screen.dart';
import 'package:vegetables/screens/products_details_screen.dart';
import 'package:vegetables/screens/user_product_screen.dart';

import '../screens/auth_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case ProductOverviewScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductOverviewScreen());
      case AuthScreen.routeName:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case ProductsDetailsScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductsDetailsScreen());
      case BottomNavScreen.routeName:
        return MaterialPageRoute(builder: (_) => BottomNavScreen());
      case UserProductScreen.routeName:
        return MaterialPageRoute(builder: (_) => UserProductScreen());
      case AddProductScreen.routeName:
        final args = settings.arguments as Map<dynamic, dynamic>;
        final id = args['id'];
        return MaterialPageRoute(
            builder: (_) => AddProductScreen(
                  id: id,
                ));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(child: Text('Route Not Found')),
            ));
  }
}
