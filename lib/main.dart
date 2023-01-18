import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/order_list.dart';

import 'package:shop/models/product_list.dart';
import 'models/cart.dart';

import 'package:shop/pages/product_detail_page.dart';
import 'pages/products_overview_page.dart';
import 'pages/cart_page.dart';
import 'pages/orders_page.dart';

import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange),
            fontFamily: 'Lato'),
        //home: ProductsOverviewPage(),
        routes: {
          AppRoutes.HOME: (ctx) => ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAILS: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
