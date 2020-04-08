import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/providers/products_provider.dart';
import 'package:shop_app/src/widgets/drawer.dart';
import 'package:shop_app/src/widgets/user_product_item.dart';

class UserProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsItems = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {
            Navigator.of(context).pushNamed('/editProducts');
          }),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsItems.products.length,
          itemBuilder: (_,index){
            return UserProductItem(productsItems.products[index]);
          }
        ),
      ),
    );
  }
}
