import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("\$hop here"),
      ),
      body: ProductsGrid(),
    );
  }
}
