import 'package:flutter/foundation.dart';
import 'dart:math';

import '../models/cart_item.dart';
import '../models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {...items};
  }

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
            id: Random().nextDouble().toString(),
            productId: product.id,
            name: product.name,
            quantity: 1,
            price: product.price),
      );
    }
    notifyListeners();
  }

  void removeId(String productId) {
    _items.remove(productId);
    notifyListeners(); //sempre que houve mudança, eu chamo o notifyListeners()
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
