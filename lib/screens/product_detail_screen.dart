import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_shop/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  static const String routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productId.toString());
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
    );
  }
}
