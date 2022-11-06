import 'package:flutter/material.dart';
import 'package:mad_project/components/rectengular_button.dart';
import 'package:mad_project/db/db_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDispose;
  ProductCard({required this.product, required this.onDispose});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder:
                          const AssetImage("assets/images/picture_loading.png"),
                      imageErrorBuilder: (c, _, __) => Image.asset(
                        'assets/images/no_picture.jpg',
                        fit: BoxFit.cover,
                        height: 100,
                        width: 50,
                      ),
                      image: NetworkImage(
                        product.imageUrl,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                getFirstWords(product.name),
                style: const TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
              Text(
                '${product.currency} ${product.currencySign}${product.price}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              title: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.fill,
                    errorBuilder: (_, __, ___) => Image.asset(
                      "assets/images/no_picture.jpg",
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "id: ${product.id}",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'category: ${product.category}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'price: ${product.currency} ${product.currencySign}${product.price}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'brand: ${product.brand.toUpperCase()}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                              child: Text(product.description)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RectengularRoundedButton(
                        color: Colors.blueAccent,
                        buttonName: 'Buy Now',
                        fontSize: 14,
                        onPressed: () async {
                          try {
                            Navigator.pop(context);
                            await launchUrl(
                              Uri.parse(product.productUrl),
                              // mode: LaunchMode.inAppWebView,
                            );
                          } catch (e) {}
                        },
                      ),
                      RectengularRoundedButton(
                          color: Colors.blue,
                          buttonName: 'Add to Cart',
                          fontSize: 14,
                          onPressed: () async {
                            await DbHelper.instance.insertProduct(product);
                            onDispose();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Item added to cart successfully"),
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.blue,
                              ),
                            );
                            Navigator.pop(context);
                          }),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  String getFirstWords(String sentence) {
    final splitted = sentence.split(" ");
    return splitted
        .sublist(0, splitted.length > 4 ? 4 : splitted.length)
        .join(" ");
  }
}
