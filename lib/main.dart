import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/pages/product_overview_page.dart';
import 'package:shop_app/src/providers/cart_provider.dart';
import 'package:shop_app/src/providers/products_provider.dart';

import 'src/pages/cart_page.dart';
import 'src/pages/edit_product_page.dart';
import 'src/pages/orders_page.dart';
import 'src/pages/product_detail_page.dart';
import 'src/pages/user_products_page.dart';
import 'src/providers/orders_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OrdersProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Some App',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.orangeAccent,
            fontFamily: 'Lato'),
        initialRoute: '/overview',
        routes: {
          '/overview': (context) => ProductsOverview(),
          '/detail': (context) => ProductDetailPage(),
          '/cart': (context) => CartPage(),
          '/orders': (context) => OrdersPage(),
          '/userProducts': (context) => UserProductsPage(),
          '/editProducts': (context) => EditProductPage(),
        },
      ),
    );
  }
}
