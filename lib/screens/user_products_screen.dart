import 'package:demo_shop/providers/products.dart';
import 'package:demo_shop/screens/edit_product_screen.dart';
import 'package:demo_shop/widgets/app_drawer.dart';
import 'package:demo_shop/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: <Widget>[
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              }),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Consumer<Products>(
                        builder: (ctx, productsData, _) => ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: ((ctx, i) => Column(
                                children: [
                                  UserProductItem(
                                      id: productsData.items[i].id,
                                      title: productsData.items[i].title,
                                      imageUrl: productsData.items[i].imageUrl),
                                  const Divider(),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
