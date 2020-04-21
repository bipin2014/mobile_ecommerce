import 'package:flutter/material.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/screens/auth_screen.dart';
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
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previousProducts) => Products(
              auth.token,
              previousProducts == null ? [] : previousProducts.items,
              auth.userId),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (ctx, auth, prevOrder) => Orders(auth.token,
              prevOrder == null ? [] : prevOrder.orders, auth.userId),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
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
          home: auth.isAuth
              ? ProductsOverViewScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, dataSnapshot) =>
                      dataSnapshot.connectionState == ConnectionState.waiting
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : AuthScreen(),
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
      ),
    );
  }
}
