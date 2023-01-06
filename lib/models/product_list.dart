import 'package:flutter/widgets.dart';
import 'package:shop/data/dummy_data.dart';
import '../models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); //notifica os interessados ao atualizar a
    //lista de produtos.
    // Para que a tela atualize a lista de productos
  }
}
