import 'package:mad_project/api_helper/extra.dart';

class Product {
  String name;
  String price;
  String description;
  String imageUrl;
  String productUrl;
  String category;
  String brand;
  String currency;
  String currencySign;
  int id;
  Product({
    required this.productUrl,
    required this.currency,
    required this.currencySign,
    required this.brand,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.id,
  });

  static Product fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"] ?? 'Unavailable',
        price: json["price"]?.toString() ?? '0.0',
        description: json["description"] == null || json["description"] == ''
            ? 'Unavailable.'
            : json["description"],
        imageUrl: json["image_link"] ??
            'https://www.clinique.com/media/export/cms/products/181x209/clq_ZKJM01_181x209.png',
        category:
            json["product_type"] ?? FilterProducts.productCategories.first,
        brand: json["brand"] ?? FilterProducts.brands.first,
        productUrl: json['product_link'] ?? 'https://www.clinique.com/',
        currency: json['currency'] ?? 'USD',
        currencySign: json['price_sign'] ?? '\$',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "image_link": imageUrl,
        "product_type": category,
        "brand": brand,
        "product_link": productUrl,
        "currency": currency,
        "price_sign": currencySign,
      };

  @override
  String toString() {
    return """Product{
    id : $id,
    name: $name,
    category: $category,
    price: Rs.$price,
    description: $description,
    }""";
  }
}
