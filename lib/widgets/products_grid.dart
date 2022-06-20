import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  ProductsGrid({
    Key? key,
  }) : super(key: key);

  final List<Product> loadedProducts = [];

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider(
          create: (context) => products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
