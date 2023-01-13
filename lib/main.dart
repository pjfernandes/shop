import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/models/product_list.dart';
import 'models/cart.dart';
//import 'package:shop/pages/counter_page.dart';
import 'package:shop/pages/product_detail_page.dart';
//import 'package:shop/providers/counter.dart';
import 'pages/products_overview_page.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange),
            fontFamily: 'Lato'),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAILS: (ctx) => ProductDetailPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
