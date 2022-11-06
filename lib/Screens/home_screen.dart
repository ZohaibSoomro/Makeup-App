import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mad_project/Screens/cart_screen.dart';
import 'package:mad_project/Screens/login_screen.dart';
import 'package:mad_project/api_helper/api_helper.dart';
import 'package:mad_project/api_helper/extra.dart';
import 'package:mad_project/components/product.dart';
import 'package:mad_project/components/product_card.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/db/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<Product> products = [];
  final apiHelper = ApiHelper();
  User? user = FirebaseAuth.instance.currentUser;
  String? chosenBrand;
  String? chosenCategory;
  int cartLength = 0;

  @override
  void initState() {
    super.initState();
    loadProducts();
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome,  ${user?.displayName}!'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Badge(
              padding: const EdgeInsets.all(3),
              badgeColor: Colors.white,
              elevation: 1,
              position: BadgePosition.topEnd(
                  top: MediaQuery.of(context).size.height * 0.008,
                  end: MediaQuery.of(context).size.width * 0.01),
              animationDuration: const Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              badgeContent: Text(
                cartLength.toString(),
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              ),
              child: IconButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, CartScreen.id);
                  cartLength =
                      (await DbHelper.instance.getAllCartProducts()).length;
                  setState(() {});
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              (await SharedPreferences.getInstance())
                  .setBool("isLoggedIn", false);
              Navigator.pushReplacementNamed(context, Login.id);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: SpinKitDoubleBounce(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven ? Colors.blue : Colors.white,
              ),
            );
          },
        ),
        opacity: 0.5,
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text('Loading Products...'),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context),
                    Flexible(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            onDispose: () async {
                              cartLength =
                                  (await DbHelper.instance.getAllCartProducts())
                                      .length;
                              setState(() {});
                            },
                            product: products[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void loadProducts() async {
    toggleLoadingStatus();
    var products = await apiHelper.getAllProducts(
        category: chosenCategory, brand: chosenBrand);
    if (products.isNotEmpty) {
      setState(() {
        this.products = products;
      });
      toggleLoadingStatus();
      print(this.products.length);
    }
  }

  toggleLoadingStatus() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: TextButton(
        onPressed: onFilterProductsButtonPressed,
        child: const Text(
          'Filter Products',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget buildListView(String listTitle, List useList,
      {required Function(int) onItemTap}) {
    final list = useList;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 15,
      ),
      child: Column(
        children: [
          Text(
            listTitle,
            style: kTitleStyle.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                elevation: 1.0,
                child: ListTile(
                  title: Text(list[index]),
                  onTap: () {
                    onItemTap(index);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  EdgeInsetsGeometry buildDialogMargin() => EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
        vertical: MediaQuery.of(context).size.height * 0.1,
      );

  buildBrandListView() {
    return buildListView(
      'Choose a brand',
      FilterProducts.brands,
      onItemTap: (index) {
        setState(() {
          chosenBrand = FilterProducts.brands[index];
          chosenCategory = null;
          loadProducts();
          Navigator.pop(context);
          Navigator.pop(context);
        });
      },
    );
  }

  buildCategoryListView() {
    return buildListView(
      'Choose a category',
      FilterProducts.productCategories,
      onItemTap: (index) {
        setState(() {
          chosenCategory = FilterProducts.productCategories[index];
          chosenBrand = null;
          loadProducts();
        });
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  buildFilterByListView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Filter By', style: kTitleStyle.copyWith(fontSize: 30)),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.3, color: Colors.blue),
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            elevation: 1.0,
            child: ListTile(
              title: const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text('Brand'),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    margin: buildDialogMargin(),
                    child: buildBrandListView(),
                  ),
                );
              },
            ),
          ),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.3, color: Colors.blue),
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ListTile(
              title: const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text('Category'),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    margin: buildDialogMargin(),
                    child: buildCategoryListView(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onFilterProductsButtonPressed() {
    showDialog(
        context: context,
        builder: (context) => Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
                vertical: MediaQuery.of(context).size.width * 0.7,
              ),
              child: buildFilterByListView(),
            ));
  }
}
