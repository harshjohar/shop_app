import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() async {
    final oldfav = isFavorite;
    isFavorite = !isFavorite;
    final url = Uri.parse(
      'https://shop-app-62ecd-default-rtdb.firebaseio.com/products/$id.json',
    );
    try {
      await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
    } catch (e) {
      isFavorite = oldfav;
    }
    notifyListeners();
  }
}
