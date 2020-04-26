import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/providers/products_provider.dart';
import 'package:shop_app/src/widgets/drawer.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final productBuild = Provider.of<ProductsProvider>(context, listen: false)
        .findProductById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(productBuild.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child: Hero(
                tag: productBuild.id,
                child: Image.network(
                  productBuild.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '${productBuild.price}',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 10,),
            Text(
              productBuild.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
