import 'package:flutter/foundation.dart';
import 'package:shop_app/src/models/cart_model.dart';
import 'package:shop_app/src/models/order_model.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderModel> _orderItems = [];

  List<OrderModel> get orderItems => _orderItems;

  void addOrder(List<CartModel> cartItems, double total) {
    _orderItems.insert(
        0,
        OrderModel(
            id: DateTime.now().toString(),
            amount: total,
            cartItems: cartItems,
            date: DateTime.now()
        )
    );
    notifyListeners();
  }
}
