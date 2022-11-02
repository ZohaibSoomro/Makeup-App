import 'package:flutter/material.dart';
import 'package:mad_project/components/product.dart';

class ShoppingCartProvider with ChangeNotifier {
  List<Product> _shoppingCart = [];
  List<Product> get shoppingCart => _shoppingCart;
  void addProduct(Product product) {
    _shoppingCart.add(product);
    notifyListeners();
  }

  void remove(String productId) {
    try {
      final product =
          _shoppingCart.firstWhere((element) => element.id == productId);
      if (product != null) {
        _shoppingCart.remove(product);
      }
    } catch (e) {}
  }
}
