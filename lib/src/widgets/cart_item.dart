import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String productId;

  CartItem({this.id, this.title, this.quantity, this.price,this.productId});

  @override
  Widget build(BuildContext context) {
    ValueKey vk = ValueKey(id);
    return Dismissible(
      key: vk,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete,color: Colors.white,),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Confirm you want to delete'),
            content: Text('Are you sure you want to delete'),
            actions: <Widget>[
              FlatButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Yes')),
              FlatButton(onPressed: () => Navigator.of(context).pop(false), child: Text('No'))
            ],
          )
        );
      },
      onDismissed: (direction){
        print('Going to remove $productId careful with the $vk');
        Provider.of<CartProvider>(context,listen: false).removeItem(productId);
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(child: Text('$price')),
          ),
        ),
        title: Text(title),
        subtitle: Text('Total: ${price * quantity}'),
        trailing: Text('$quantity'),
      ),
    );
  }
}
