import 'package:flutter/material.dart';

class CartListItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  const CartListItem({
    Key? key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: FittedBox(
              child: Text('$quantity x'),
            ),
          ),
          title: Text(
            title,
          ),
          subtitle: Text(
            'Total: \$${(price * quantity)}',
          ),
          trailing: Text('\$ $price'),
        ),
      ),
    );
  }
}
