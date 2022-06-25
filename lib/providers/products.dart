import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  } // return copy, not by reference

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
      'https://shop-app-62ecd-default-rtdb.firebaseio.com/products.json',
    );

    try {
      final res = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      final resProduct = json.decode(res.body);
      final newProduct = Product(
        id: resProduct['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final idx = _items.indexWhere((element) => element.id == id);
    final url = Uri.parse(
      'https://shop-app-62ecd-default-rtdb.firebaseio.com/products/$id.json',
    );
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          },
        ),
      );
      _items[idx] = newProduct;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void deleteProduct(String id) {
    final url = Uri.parse(
      'https://shop-app-62ecd-default-rtdb.firebaseio.com/products/$id.json',
    );
    final existingProductIdx = _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIdx];
    _items.removeAt(existingProductIdx);
    try {
      http.delete(url);
      notifyListeners();
    } catch (e) {
      _items.insert(existingProductIdx, existingProduct);
      rethrow;
    }
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
      'https://shop-app-62ecd-default-rtdb.firebaseio.com/products.json',
    );

    try {
      final res = await http.get(url);
      final data = json.decode(res.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      data.forEach((id, prodData) {
        loadedProducts.add(
          Product(
            id: id,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
