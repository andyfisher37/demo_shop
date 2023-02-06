import 'package:demo_shop/providers/cart.dart';
import 'package:demo_shop/providers/product.dart';
import 'package:demo_shop/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final _scaffoldMess = ScaffoldMessenger.of(context);

    return Consumer<Product>(
        builder: (ctx, product, child) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                footer: GridTileBar(
                  leading: IconButton(
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () async {
                      try {
                        await product.toggleFavoriteStatus();
                      } catch (error) {
                        _scaffoldMess.showSnackBar(const SnackBar(
                            content: Text(
                          'Server error...',
                          textAlign: TextAlign.center,
                        )));
                      }
                    },
                  ),
                  trailing: Consumer<Cart>(
                    builder: (ctx, cart, child) => IconButton(
                      icon: const Icon(Icons.shopping_basket),
                      onPressed: () {
                        cart.addItem(product.id, product.price, product.title);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Added ${product.title} to cart'),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              cart.removeSingleItem(product.id);
                            },
                          ),
                        ));
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
                  child: Center(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: product.imageUrl,
                    ),
                  ),
                  // child: Image.network(
                  //   product.imageUrl,
                  //   fit: BoxFit.cover,
                  //                ),
                ),
              ),
            ));
  }
}
