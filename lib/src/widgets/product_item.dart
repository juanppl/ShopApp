import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/models/product_model.dart';
import 'package:shop_app/src/providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productoModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed('/detail', arguments: productoModel.id),
        child: GridTile(
          child: Image.network(
            productoModel.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            title: Text(productoModel.title),
            leading: IconButton(
                icon: Icon(productoModel.isFavorite? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  productoModel.toogleIsFavorite();
                }),
            trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  cartProvider.addItem(productoModel.id, productoModel.title, productoModel.price);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to cart'),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'Undo', 
                        onPressed: (){
                          cartProvider.undoTheAdditionToCart(productoModel.id);
                        }
                      ),
                    )
                  );
                },
              ),
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}
