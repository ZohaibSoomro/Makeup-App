import 'package:flutter/material.dart';
import 'package:mad_project/components/rectengular_button.dart';
import 'package:mad_project/components/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                product.name,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Rs. ${product.price}',
                style: const TextStyle(fontSize: 18),
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
              title: Image.asset(
                'assets/images/google.png',
                fit: BoxFit.cover,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rs. ${product.price}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'stock: ${product.stock}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'rating ${product.rating}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(product.description),
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
                          onPressed: () {}),
                      RectengularRoundedButton(
                          color: Colors.blue,
                          buttonName: 'Add to Cart',
                          fontSize: 14,
                          onPressed: () {
                            context
                                .read<ShoppingCartProvider>()
                                .addProduct(product);
                            onDispose();
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
}
