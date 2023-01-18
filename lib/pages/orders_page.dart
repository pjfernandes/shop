import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/components/app_drawer.dart';
import '../components/order.dart';

import '../models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus pedidos"),
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, index) =>
            OrderWidget(order: orders.items[index]),
      ),
      drawer: AppDrawer(),
    );
  }
}
