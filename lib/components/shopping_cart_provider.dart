// import 'package:flutter/material.dart';
// import 'package:mad_project/components/product.dart';
// import 'package:mad_project/db/db_helper.dart';
//
// class ShoppingCartProvider with ChangeNotifier {
//   List<Product> _shoppingCart = [];
//   List<Product> get shoppingCart => _shoppingCart;
//   Future<void> addProduct(Product product) async {
//     await DbHelper.instance.insertProduct(product);
//     _shoppingCart.add(product);
//     notifyListeners();
//   }
//
//   Future<void> removeAllProducts() async {
//     await DbHelper.instance.clearCart();
//     _shoppingCart.clear();
//     notifyListeners();
//   }
//
//   Future<void> removeProduct(int productId) async {
//     try {
//       await DbHelper.instance.deleteProduct(productId);
//       final product =
//           _shoppingCart.firstWhere((element) => element.id == productId);
//       if (product != null) {
//         _shoppingCart.remove(product);
//       }
//       print("Cart item with id $productId removed successfully");
//       notifyListeners();
//     } catch (e) {}
//   }
// }
