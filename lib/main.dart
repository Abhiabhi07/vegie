import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:vegetables/provider/action_provider.dart';
import 'package:vegetables/provider/products_provider.dart';
import 'package:vegetables/route/route.dart';
import 'package:vegetables/screens/auth_screen.dart';

import 'provider/products.dart';

void main() {
  runApp(MultiProvider(builder: (context, c) => const MyApp(), providers: [
    ChangeNotifierProvider(
      create: (context) => ActionProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => Products(),
    ),
  ]));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffF5F5F5),
          inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.grey[200],
              prefixIconColor: Colors.black,
              hintStyle: TextStyle(color: Colors.black87)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: GoogleFonts.poppins().fontFamily,
          useMaterial3: true,
        ),
        home: AuthScreen(),
        initialRoute: AuthScreen.routeName,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
