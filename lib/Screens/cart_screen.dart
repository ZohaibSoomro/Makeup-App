import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/db/db_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/product.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart_screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> products = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(products.isEmpty
                      ? 'Cart is already empty.'
                      : "Cart cleared successfully."),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.blue,
                ),
              );
              if (products.isNotEmpty) {
                await DbHelper.instance.clearCart();
                loadCartProducts();
              }
              setState(() {});
            },
            icon: Icon(Icons.clear, size: 20),
            label: Text('Remove all'),
          ),
        ],
      ),
      body: LoadingOverlay(
        progressIndicator: SpinKitDoubleBounce(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven ? Colors.blue : Colors.white,
              ),
            );
          },
        ),
        isLoading: isLoading,
        child: products.isEmpty
            ? Center(
                child: Text('Cart has no items.',
                    style: kTitleStyle.copyWith(fontSize: 30)))
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, index) =>
                    buildCartItemTile(index),
                scrollDirection: Axis.vertical,
              ),
      ),
    );
  }

  Widget buildCartItemTile(int index) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              try {
                await launchUrl(
                  Uri.parse(products[index].productUrl),
                  mode: LaunchMode.inAppWebView,
                );
                removeItemFromCart(this.context, index);
              } catch (e) {}
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.shopping_cart,
            label: 'Buy now',
          ),
          SlidableAction(
            onPressed: (context) {
              removeItemFromCart(this.context, index);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Remove',
          ),
        ],
      ),
      child: buildCartItemContent(index),
    );
  }

  Padding buildCartItemContent(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'Swipe left for more option',
            style: TextStyle(color: Colors.blue, fontSize: 10),
          ),
          Card(
            margin: const EdgeInsets.all(0),
            elevation: 2.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              contentPadding: const EdgeInsets.all(5),
              title: Text(products[index].name),
              subtitle: Text(
                  '${products[index].currency} ${products[index].currencySign}${products[index].price}'),
              leading: buildLeadingPicture(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLeadingPicture(index) {
    return Card(
      elevation: 2.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          fit: BoxFit.cover,
          placeholder: const AssetImage("assets/images/picture_loading.png"),
          imageErrorBuilder: (c, _, __) => Image.asset(
            'assets/images/no_picture.jpg',
            fit: BoxFit.cover,
          ),
          image: NetworkImage(
            products[index].imageUrl,
          ),
        ),
      ),
    );
  }

  Future<void> removeItemFromCart(context, index) async {
    await DbHelper.instance.deleteProduct(products[index].id);
    loadCartProducts();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item removed from cart successfully"),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.blue,
      ),
    );
    setState(() {});
  }

  void loadCartProducts() async {
    setState(() {
      isLoading = true;
    });
    final prdcts = await DbHelper.instance.getAllCartProducts();
    products = prdcts;
    setState(() {
      isLoading = false;
    });
  }
}
