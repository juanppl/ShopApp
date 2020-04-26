import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/providers/cart_provider.dart';
import 'package:shop_app/src/providers/orders_provider.dart';
import 'package:shop_app/src/widgets/cart_item.dart';
import 'package:shop_app/src/widgets/drawer.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    cartProvider.totalPrice.toStringAsFixed(2),
                    style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                FlatButton(
                  onPressed: () async{
                    await Provider.of<OrdersProvider>(context,listen: false).addOrder(cartProvider.cartItems.values.toList(), cartProvider.totalPrice);
                    cartProvider.clearCart();
                  },
                  child: Text('Order'),
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) => CartItem(
                id: cartProvider.cartItems.values.toList()[i].id,
                title: cartProvider.cartItems.values.toList()[i].title,
                price: cartProvider.cartItems.values.toList()[i].price,
                quantity: cartProvider.cartItems.values.toList()[i].quantity,
                productId: cartProvider.cartItems.keys.toList()[i],
              ),
              itemCount: cartProvider.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
