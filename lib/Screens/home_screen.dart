import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/Screens/cart_screen.dart';
import 'package:mad_project/components/product.dart';
import 'package:mad_project/components/product_card.dart';
import 'package:mad_project/components/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Badge(
              padding: const EdgeInsets.all(3),
              badgeColor: Colors.white,
              elevation: 1,
              position: BadgePosition.topEnd(top: 5, end: -2),
              animationDuration: const Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              badgeContent: Text(
                context
                    .read<ShoppingCartProvider>()
                    .shoppingCart
                    .length
                    .toString(),
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                'Products',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                ),
                scrollDirection: Axis.vertical,
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    onDispose: () {
                      setState(() {});
                    },
                    product: Product(
                      id: index.toString(),
                      name: 'item#$index',
                      price: (index + 1) * 100,
                      description:
                          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto',
                      imageUrl: 'assets/images/google.png',
                      rating: 4.5,
                      stock: 69,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
