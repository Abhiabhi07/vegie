import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as htp;
import 'package:vegetables/constants.dart';
import 'package:vegetables/screens/btm_nav_screen.dart';

class AuthProvider {
  Future<void> registerUser({
    required String userName,
    required String email,
    required String mobile,
    required String password,
    required BuildContext context,
  }) async {
    final url =
        Uri.parse('https://shareittofriends.com/demo/flutter/Register.php');

    try {
      var response = await htp.post(url, body: {
        'name': userName,
        'email': email,
        'mobile': mobile,
        'password': password,
      });

      var responseBody = jsonDecode(response.body);
      print('responsee $responseBody');
      if (response.statusCode == 200) {
        userToken = responseBody['data']['user_token'];
        showtoast(responseBody['message'], Colors.green);
        Navigator.of(context).pushReplacementNamed(BottomNavScreen.routeName);
      } else {
        showtoast(responseBody['message'], Colors.red);
      }

      print('response codee -- ${response.statusCode}');
      print('rsponse body -- $responseBody');
    } catch (e) {
      print('e 1 $e');
      showtoast(e.toString(), Colors.red);
    }
  }

  Future<void> loginUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    final url =
        Uri.parse('https://shareittofriends.com/demo/flutter/Login.php');
    try {
      var response = await htp.post(url, body: {
        'email': email,
        'password': password,
      });
      var responseBody = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('tokenr${responseBody['data']['user_token']}');
        userToken = responseBody['data']['user_token'];

        showtoast(responseBody['message'], Colors.green);
        Navigator.of(context).pushReplacementNamed(BottomNavScreen.routeName);
      } else {
        showtoast(responseBody['message'], Colors.red);
      }
    } catch (e) {}
  }
}
