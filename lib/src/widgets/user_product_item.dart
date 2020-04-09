import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/models/product_model.dart';
import 'package:shop_app/src/providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final ProductModel product;

  UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed('/editProducts',arguments: product.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<ProductsProvider>(context,listen: false).removeProduct(product.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
