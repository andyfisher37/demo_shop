import 'package:flutter/material.dart';
import '/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'https://m.media-amazon.com/images/I/61oC5CPd7eL._UX679_.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'https://m.media-amazon.com/images/I/61yRUBQInKL._UX679_.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'https://m.media-amazon.com/images/I/81mVtWb8BWL._UX679_.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'https://m.media-amazon.com/images/I/5144RhX7CvS._SX679_.jpg',
    ),
  ];

  List<Product> get items {
    return [...items];
  }

  void addProduct() {
    notifyListeners();
  }
}
