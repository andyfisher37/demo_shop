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
      //appBar: AppBar(title: Text(loadedProduct.title)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 10),
            // Price of current product
            Text(
              '\$${loadedProduct.price}',
              style: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 35, 35, 35)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Description of current product
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 800),
            // Container(
            //   height: 300,
            //   width: double.infinity,
          ])),
        ],
      ),
    );
  }
}
