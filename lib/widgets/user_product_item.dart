import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  UserProductItem({super.key, required this.title, required this.imageUrl});

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
                // Edit...
              }),
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: (() {
                // Delete...
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
