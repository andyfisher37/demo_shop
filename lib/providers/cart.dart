import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    int res = 0;
    _items.forEach((key, item) {
      res += item.quantity;
    });
    return res;
  }

  double get totalAmount {
    double res = 0.0;
    _items.forEach((key, item) {
      res += item.price * item.quantity;
    });
    return res;
  }

  void addItem(String prodId, double price, String title) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (exCartItem) => CartItem(
              id: exCartItem.id,
              title: exCartItem.title,
              quantity: exCartItem.quantity + 1,
              price: exCartItem.price));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (exCartItem) => CartItem(
              id: exCartItem.id,
              title: exCartItem.title,
              quantity: exCartItem.quantity - 1,
              price: exCartItem.price));
    } else {
      removeItem(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
