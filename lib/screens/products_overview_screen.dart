import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/widgets/badge.dart';
import 'package:shopapp/widgets/main_drawer.dart';
import 'package:shopapp/widgets/products_grid.dart';

enum FiltersOptions { Favourites, All_Item }

class ProductsOverViewScreen extends StatefulWidget {
  static const url = '/';

  @override
  _ProductsOverViewScreenState createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var _showOnlyFavourites = false;
  bool init = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (init) {
      _isLoading = true;
      Provider.of<Products>(context).fetchdata().then((value) {
        _isLoading = false;
      });
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FiltersOptions selectedValue) {
              setState(() {
                if (selectedValue == FiltersOptions.All_Item) {
                  _showOnlyFavourites = false;
                } else {
                  _showOnlyFavourites = true;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favorites"),
                value: FiltersOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FiltersOptions.All_Item,
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              child: child,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.url);
              },
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavourites),
    );
  }
}
