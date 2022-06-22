import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyfavs = false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("\$hop here"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.favorites) {
                  _showOnlyfavs = true;
                } else {
                  _showOnlyfavs = false;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text("Only Favs"),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text("Show All"),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (context, value, child) => Badge(
              value: value.itemCount.toString(),
              color: Theme.of(context).colorScheme.secondary,
              child: child as Widget,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: ProductsGrid(_showOnlyfavs),
      drawer: const AppDrawer(),
    );
  }
}
