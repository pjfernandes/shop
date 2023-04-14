import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../excepetions/http_expection.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();

    final response = await http.patch(
      Uri.parse('${Constants.productBaseUrl}/$id.json'),
      body: jsonEncode(
        {"isFavorite": isFavorite},
      ),
    );

    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException(
          msg: 'Não foi possível favoritar', statusCode: response.statusCode);
    }
  }
}
