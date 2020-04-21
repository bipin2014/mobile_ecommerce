import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/widgets/main_drawer.dart';
import 'package:shopapp/widgets/user_product_item.dart';

import 'edit_product.dart';

class UserProductScreen extends StatelessWidget {
  static const url = "/user-product-screen";

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchdata(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.url);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProduct(context),
                    child: Consumer<Products>(
                      builder: (ctx, productData, _) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemBuilder: (ctx, i) => Column(
                            children: <Widget>[
                              UserProductItem(
                                productData.items[i].id,
                                productData.items[i].title,
                                productData.items[i].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                          itemCount: productData.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
