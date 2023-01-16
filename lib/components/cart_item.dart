import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(Icons.delete),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20)),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(cartItem.name),
            subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
            trailing: Text('${cartItem.quantity}x'),
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('R\$${cartItem.price}'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
