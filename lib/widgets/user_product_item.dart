import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product.dart';

class UserProductitem extends StatelessWidget {
  const UserProductitem(
      {Key? key, required this.title, required this.imageUrl, required this.id})
      : super(key: key);
  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            icon: const Icon(Icons.edit),
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            onPressed: () {
              Provider.of<Products>(context, listen: false).deleteProduct(id);
            },
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
