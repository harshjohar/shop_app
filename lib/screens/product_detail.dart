import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/widgets/badge.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-details';
  const ProductDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final productData = Provider.of<Products>(context, listen: false);
    final product = productData.findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          Badge(
            value: cart.itemCount.toString(),
            color: Theme.of(context).colorScheme.secondary,
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            alignment: Alignment.center,
            child: Image.network(product.imageUrl),
          ),
          const SizedBox(height: 10),
          Text(
            product.title,
            style: const TextStyle(fontSize: 40),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          Text(
            '\$ ${product.price.toString()}',
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                cart.addItem(productId, product.price, product.title);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_cart),
                  Text("Add to cart"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
