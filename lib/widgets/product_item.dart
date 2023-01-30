import 'package:demo_shop/providers/cart.dart';
import 'package:demo_shop/providers/product.dart';
import 'package:demo_shop/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
        builder: (ctx, product, child) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                footer: GridTileBar(
                  leading: IconButton(
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      product.toggleFavoriteStatus();
                    },
                  ),
                  trailing: Consumer<Cart>(
                    builder: (ctx, cart, child) => IconButton(
                      icon: const Icon(Icons.shopping_basket),
                      onPressed: () {
                        cart.addItem(product.id, product.price, product.title);
                      },
                    ),
                  ),
                  backgroundColor: Colors.black54,
                  title: Text(
                    product.title,
                    textAlign: TextAlign.center,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductDetailScreen.routeName,
                      arguments: product.id,
                    );
                  },
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ));
  }
}
