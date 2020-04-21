import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const url = "/product-details";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 350,
            width: double.infinity,
            child: Hero(
              tag: loadedProduct.id,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(loadedProduct.title,
            style: Theme.of(context).textTheme.headline6,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(loadedProduct.description,style: Theme.of(context).textTheme.headline1,),
          ),
        ],
      ),
    );
  }
}
