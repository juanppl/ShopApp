import 'package:flutter/foundation.dart';
import 'cart_model.dart';

class OrderModel {
  final String id;
  final double amount;
  final List<CartModel> cartItems;
  final DateTime date;

  OrderModel({
    @required this.id,
    @required this.amount,
    @required this.cartItems,
    @required this.date
  });
}