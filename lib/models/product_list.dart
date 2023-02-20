import 'package:flutter/widgets.dart';
import 'package:shop/data/dummy_data.dart';

import 'dart:math';

import '../models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      items.where((product) => product.isFavorite).toList();

  int itemCount() {
    return items.length;
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); //notifica os interessados ao atualizar a
    //lista de produtos.
    // Para que a tela atualize a lista de productos
  }

  void removeProduct(Product product) {
    _items.removeWhere((p) => product.id == p.id);
    notifyListeners();
  }

  void saveProduct(Map<String, Object> formData) {
    bool hasId = formData['id'] != null;

    final Product product = Product(
      id: hasId ? formData["id"].toString() : Random().nextDouble().toString(),
      name: formData['name'].toString(),
      description: formData['description'].toString(),
      price: formData['price'] as double,
      imageUrl: formData['imageUrl'].toString(),
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
    notifyListeners();
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
