import 'package:demo_shop/providers/products.dart';
import 'package:demo_shop/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const UserProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: (() {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              }),
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: (() {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              }),
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
