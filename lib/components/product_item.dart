import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/utils/app_routes.dart';

import '../models/product.dart';
import '../models/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAILS,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
              product.toggleFavorite();
            },
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
          title: Text(product.name),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
