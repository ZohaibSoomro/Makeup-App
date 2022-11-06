import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../components/product.dart';

class DbHelper {
  static DbHelper instance = DbHelper._init();
  DbHelper._init();
  Database? _database;
  static String dbName = "Shopping.db";
  static String tableName = "Cart";
  Future<Database> get database async => _database ??= await openDatabase(
        join(await getDatabasesPath(), dbName),
        onCreate: onCreate,
        version: 1,
      );

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
        """CREATE TABLE $tableName(id INTEGER, name Text, price String, description Text, 
                image_link Text, product_link Text, product_type Text, brand Text, currency Text, price_sign Text )""");
    print("Table $tableName created");
  }

  Future<void> insertProduct(Product product) async {
    final db = await instance.database;
    var result = await db.insert(tableName, product.toJson());
    print("data inserted ${result}");
  }

  Future clearCart() async {
    final db = await instance.database;
    final rows = await db.delete(tableName);
    print("$rows deleted succesfully, cart is empty now!");
  }

  Future<void> deleteProduct(int id) async {
    final db = await instance.database;
    var result = await db.delete(
      tableName,
      where: 'id=?',
      whereArgs: [id],
    );
    print("data deleted ${result}");
  }

  Future<List<Product>> getAllCartProducts() async {
    List<Product> products = [];
    final db = await instance.database;
    final result = await db.query(tableName);
    for (final data in result) {
      try {
        final product = Product.fromJson(data);
        print(product);
        products.add(product);
      } catch (e) {
        print("Rully wyse $e");
      }
    }
    return products;
  }
}
