import 'dart:convert';

import 'package:http/http.dart' as http;

import '../components/product.dart';

class ApiHelper {
  static const kHerokuMakeupApiUrl =
      "https://makeup-api.herokuapp.com/api/v1/products.json";

  Future<List<Product>> getAllProducts(
      {String? category, String? brand}) async {
    List<Product> products = [];
    var url = "";
    if (category == null) {
      brand = brand ?? "maybelline";
      url = "$kHerokuMakeupApiUrl?brand=$brand";
    } else {
      url = "$kHerokuMakeupApiUrl?product_type=$category";
    }
    try {
      final resp = await http.get(Uri.parse(url));
      print(resp.statusCode);
      final data = jsonDecode(resp.body) as List;
      for (var productJson in data) {
        if (productJson["price"] == null || productJson["price"] == "0.0") {
          continue;
        }
        final product = Product.fromJson(productJson);
        products.add(product);
      }
    } catch (e) {
      print("Achie wai na exception $e");
    }
    return products;
  }
}
