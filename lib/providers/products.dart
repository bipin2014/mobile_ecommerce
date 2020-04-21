import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopapp/models/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description: 'A nice pair of trousers.',
//      price: 59.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Yellow Scarf',
//      description: 'Warm and cozy - exactly what you need for the winter.',
//      price: 19.99,
//      imageUrl:
//          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//    ),
//    Product(
//      id: 'p4',
//      title: 'A Pan',
//      description: 'Prepare any meal you want.',
//      price: 49.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//    ),
  ];

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavourite).toList();
  }

  Future<void> addProduct(Product product) async {
    final String url = 'https://korean-meaning.firebaseio.com/products.json';
    try {
      final value = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavourite': product.isFavourite,
          }));
      final newProduct = Product(
        id: json.decode(value.body)['name'],
        imageUrl: product.imageUrl,
        price: product.price,
        description: product.description,
        title: product.title,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchdata() async {
    final url = "https://korean-meaning.firebaseio.com/products.json";

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
//      print(extractedData);
      if (extractedData == null) {
        return;
      }
      final List<Product> list = [];
      extractedData.forEach((key, value) {
        list.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          isFavourite: value['isFavourite'],
        ));
      });
      _items = list;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = "https://korean-meaning.firebaseio.com/products/$id.json";
      try {
        http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price,
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (e) {
        throw e;
      }
    }
    notifyListeners();
    return Future.value();
  }

  Future<void> deleteProduct(String id) async {
    final elementIndex = _items.indexWhere((element) => element.id == id);
    var elementData = _items[elementIndex];
    _items.removeAt(elementIndex);
    notifyListeners();
    final url = "https://korean-meaning.firebaseio.com/products/$id.json";
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(elementIndex, elementData);
      notifyListeners();
      throw HttpException("Could not delete");
    }
    elementData = null;
  }
}