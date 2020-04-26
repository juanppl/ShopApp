import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/pages/auth_page.dart';
import 'package:shop_app/src/pages/product_overview_page.dart';
import 'package:shop_app/src/providers/cart_provider.dart';
import 'package:shop_app/src/providers/products_provider.dart';

import 'src/pages/cart_page.dart';
import 'src/pages/edit_product_page.dart';
import 'src/pages/orders_page.dart';
import 'src/pages/product_detail_page.dart';
import 'src/pages/splash_page.dart';
import 'src/pages/user_products_page.dart';
import 'src/providers/auth_provider.dart';
import 'src/providers/orders_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (context) => ProductsProvider(null,null,[]),
          update: (context, authData, previousProducts) => ProductsProvider(
              authData.getToken(),
              authData.userId,
              previousProducts == null ? [] : previousProducts.products),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (context) => OrdersProvider(null,null,[]),
          update: (context, authData, previousOrders) => OrdersProvider(
              authData.getToken(),
              authData.userId,
              previousOrders == null ? [] : previousOrders.orderItems),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authData, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Some App',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.orangeAccent,
                fontFamily: 'Lato'),
            home: authData.isAuthenticated 
              ? ProductsOverview() 
              : FutureBuilder(
                  future: authData.tryAutologin(),
                  builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                  ? SplashPage()
                  : AuthPage(),
                ),
            routes: {
              '/overview': (context) => ProductsOverview(),
              '/detail': (context) => ProductDetailPage(),
              '/cart': (context) => CartPage(),
              '/orders': (context) => OrdersPage(),
              '/userProducts': (context) => UserProductsPage(),
              '/editProducts': (context) => EditProductPage(),
              '/auth': (context) => AuthPage(),
            },
          )
      ),
    );
  }
}
