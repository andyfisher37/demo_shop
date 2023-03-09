import 'dart:convert';

import 'package:demo_shop/models/http_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavStatus(bool newVal) {
    isFavorite = newVal;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String authToken) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final Uri urlUpdate = Uri.parse(
        'https://fir-shop-3ba2c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');

    final response = await patch(urlUpdate,
        body: json.encode({
          'isFavorite': isFavorite,
        }));
    if (response.statusCode >= 400) {
      _setFavStatus(oldStatus);
      throw HttpException('Server error...');
    }
  }
}
