import 'package:demo_shop/providers/products.dart';
import 'package:demo_shop/widgets/app_drawer.dart';
import 'package:demo_shop/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: <Widget>[
          IconButton(
              onPressed: (() {
                //...
              }),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: ((ctx, i) => Column(
                children: [
                  UserProductItem(
                      title: productsData.items[i].title,
                      imageUrl: productsData.items[i].imageUrl),
                  const Divider(),
                ],
              )),
        ),
      ),
    );
  }
}
