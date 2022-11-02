import 'package:flutter/material.dart';
import 'package:mad_project/components/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

import '../components/product.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart_screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    products = context.read<ShoppingCartProvider>().shoppingCart;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(products[index].name),
            tileColor: Colors.greenAccent.shade400,
            textColor: Colors.white,
            subtitle: Text('Rs. ${products[index].price}'),
            leading: CircleAvatar(
              backgroundImage: AssetImage(products[index].imageUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
