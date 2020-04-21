import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/edit_product.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/product_details_screen.dart';
import 'package:shopapp/screens/products_overview_screen.dart';
import 'package:shopapp/screens/user_product_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
//        canvasColor: Colors.white10,
          fontFamily: 'Lato',
          textTheme: Theme.of(context).textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 25,
                fontFamily: "Anton",
                color: Theme.of(context).primaryColorDark,
              ),
              headline1: TextStyle(
                fontSize: 18,
              )),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          ProductsOverViewScreen.url: (ctx) => ProductsOverViewScreen(),
          ProductDetailScreen.url: (ctx) => ProductDetailScreen(),
          CartScreen.url: (ctx) => CartScreen(),
          OrdersScreen.url: (ctx) => OrdersScreen(),
          UserProductScreen.url: (ctx) => UserProductScreen(),
          EditProductScreen.url: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
