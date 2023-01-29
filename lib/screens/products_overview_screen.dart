import 'package:demo_shop/providers/products.dart';
import 'package:demo_shop/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
  Basket,
}

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    //final productsContainer = Provider.of<Products>(context, listen: false);

    var _showFavoritesOnly = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Shop'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              ),
              const PopupMenuItem(
                value: FilterOptions.Basket,
                child: Text('Show basket'),
              ),
            ],
            onSelected: (FilterOptions value) {
              if (value == FilterOptions.Favorites) {
                _showFavoritesOnly = true;
              } else if (value == FilterOptions.All) {
                _showFavoritesOnly = false;
              } else {
                //...
              }
            },
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
