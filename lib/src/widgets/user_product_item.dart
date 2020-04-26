import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/models/product_model.dart';
import 'package:shop_app/src/providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final ProductModel product;
  UserProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
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
                Navigator.of(context)
                    .pushNamed('/editProducts', arguments: product.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .removeProduct(product.id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text('Failed deleting product'),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
