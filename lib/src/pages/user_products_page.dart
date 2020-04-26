import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/providers/products_provider.dart';
import 'package:shop_app/src/widgets/drawer.dart';
import 'package:shop_app/src/widgets/user_product_item.dart';

class UserProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsItems = Provider.of<ProductsProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/editProducts');
              }),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: productsItems.fetchAllProducts(true),
        builder:(context, snapshot) => snapshot.connectionState == ConnectionState.waiting ?
        Center(child: CircularProgressIndicator(),)
        : RefreshIndicator(
          onRefresh: () async => await productsItems.fetchAllProducts(true),
          child: Consumer<ProductsProvider>(
            builder: (context, productsItems,_) => Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: productsItems.products.length,
                  itemBuilder: (_, index) {
                    return UserProductItem( product: productsItems.products[index]);
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
