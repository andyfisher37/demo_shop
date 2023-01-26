import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({super.key});

  final List<Product> loadedProducts = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Shop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: ((ctx, i) => ProductItem(
            id: loadedProducts[i].id,
            title: loadedProducts[i].title,
            imageUrl: loadedProducts[i].imageUrl)),
      ),
    );
  }
}
