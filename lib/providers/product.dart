import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.isFavourite = false});

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        "https://korean-meaning.firebaseio.com/userFavourites/$userId/$id.json?auth=$token";
    var response =
        await http.put(url, body: json.encode(isFavourite));
    if (response.statusCode >= 400) {
      isFavourite = !isFavourite;
      notifyListeners();
      throw new HttpException("Favourites updated failed");
    }
  }
}
