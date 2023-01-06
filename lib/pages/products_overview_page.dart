import 'package:flutter/material.dart';
import '../components/product_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minha loja")),
      body: ProductGrid(),
    );
  }
}
