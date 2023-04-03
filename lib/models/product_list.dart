import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:http/http.dart' as http;

import 'dart:math';

import '../models/product.dart';

class ProductList with ChangeNotifier {
  final String baseUrl = "https://shop2-9f57b-default-rtdb.firebaseio.com";
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      items.where((product) => product.isFavorite).toList();

  int itemCount() {
    return items.length;
  }

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      items.add(Product(
        id: productData['id'],
        description: productData['description'],
        name: productData['name'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite'],
      ));
    });
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse("$baseUrl/products.json"),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      ),
    );

    notifyListeners(); //notifica os interessados ao atualizar a
    //lista de produtos.
    // Para que a tela atualize a lista de productos
  }

  void removeProduct(String productId) {
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> formData) {
    bool hasId = formData['id'] != null;

    final Product product = Product(
      id: hasId ? formData["id"].toString() : Random().nextDouble().toString(),
      name: formData['name'].toString(),
      description: formData['description'].toString(),
      price: formData['price'] as double,
      imageUrl: formData['imageUrl'].toString(),
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }
}

// bool _showFavoriteOnly = false;

// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }

// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }

// List<Product> get items {
//   if (_showFavoriteOnly) {
//     return _items.where((product) => product.isFavorite).toList();
//   }
//   return [...items];
// }
