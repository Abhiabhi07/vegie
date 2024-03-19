import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

var userToken = '';

const Color textColor = Color(0xff2D0C57);
var selectedPage = 0;

void showtoast(String msg, Color color) {
  showToast(msg,
      backgroundColor: color,
      duration: const Duration(seconds: 4),
      radius: 10,
      position: ToastPosition.bottom,
      textPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5));
}
