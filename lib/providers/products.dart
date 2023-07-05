import 'package:demo_shop/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Products with ChangeNotifier {
  // List of products
  List<Product> _items = [];

  // authorization user token
  final String authToken;
  final String userId;

  // Products constructor
  Products(this.authToken, this.userId, this._items);

  // Get the list of products
  List<Product> get items {
    return [..._items];
  }

  // Get the favorite products
  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  // Find product by Id
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // Update from base list of products...
  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final Uri url = Uri.parse(
        'https://fir-shop-3ba2c-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken&$filterString');
    try {
      final response = await get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final favoriteRes = await get(Uri.parse(
          'https://fir-shop-3ba2c-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken'));
      final favoriteData = json.decode(favoriteRes.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
        _items = loadedProducts;
        notifyListeners();
      });
    } catch (error) {
      rethrow;
    }
  }

  // Add product to list of products
  Future<void> addProduct(Product product) async {
    final Uri url = Uri.parse(
        'https://fir-shop-3ba2c-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken');
    try {
      final response = await post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'creatorId': userId,
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      try {
        final Uri urlUpdate = Uri.parse(
            'https://fir-shop-3ba2c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
        await patch(urlUpdate,
            body: json.encode({
              'title': newProduct.title,
              'price': newProduct.price,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {}
  }

  Future<void> deleteProduct(String id) async {
    final Uri urlDelete = Uri.parse(
        'https://fir-shop-3ba2c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere(((prod) => prod.id == id));
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await delete(urlDelete);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product!');
    }
    existingProduct.dispose();
  }
}
