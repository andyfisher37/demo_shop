import 'package:demo_shop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const ProductItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        leading: IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {},
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_basket),
          onPressed: () {},
        ),
        backgroundColor: Colors.black54,
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
