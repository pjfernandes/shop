import 'package:flutter/material.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:provider/provider.dart';

import '../models/product_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Produtos"),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemCount(),
          itemBuilder: (ctx, i) => Text(products.items[i].name),
        ),
      ),
    );
  }
}
