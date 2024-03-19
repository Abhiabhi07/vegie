import 'package:flutter/material.dart';

class ActionProvider extends ChangeNotifier {
  var isLogin = false;
  var isVisible = true;
  var isAuthLoading = false;
  var index = 0;
  var isProductLoading = false;
  var isDeleteLoading = false;

  void isProductTrue() {
    isProductLoading = true;
    notifyListeners();
  }

  void isProductFalse() {
    isProductLoading = false;
    notifyListeners();
  }

  void incrementIndex(int ind) {
    index = ind;
    notifyListeners();
  }

  void isAuthTrue() {
    isAuthLoading = true;
    notifyListeners();
  }

  void isAuthFalse() {
    isAuthLoading = false;
    notifyListeners();
  }

  void toggleObscureStatus() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void toggleLoginStatus() {
    isLogin = !isLogin;
    notifyListeners();
  }
}
