import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/src/models/order_model.dart';

class OrderItem extends StatefulWidget {
  final OrderModel orderModel;
  const OrderItem({this.orderModel});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _isExpanded
          ? min(widget.orderModel.cartItems.length * 20.0 + 150, 220.0)
          : 100,
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(widget.orderModel.amount.toString()),
              subtitle: Text(DateFormat.yMMMd().format(widget.orderModel.date)),
              trailing: IconButton(
                  icon:
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  }),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              height: _isExpanded ? min(widget.orderModel.cartItems.length * 20.0 + 20, 100.0) : 0,
              child: ListView(
                children: widget.orderModel.cartItems.map((item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        item.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Quentity: ${item.quantity} - Price: ${item.price}'),
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
