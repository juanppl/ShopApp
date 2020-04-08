import 'package:flutter/material.dart';
import 'package:shop_app/src/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  double get totalPrice {
    double total = 0.0;
    _cartItems.values.toList().forEach((item) {
      total += (item.price * item.quantity);
    });
    return total;
  }

  void addItem(String id, String title, double price) {
    if (_cartItems.containsKey(id)) {
      _cartItems.update(
          id,
          (oldItem) => CartModel(
              id: oldItem.id,
              title: oldItem.title,
              price: oldItem.price,
              quantity: oldItem.quantity + 1));
    } else {
      _cartItems.putIfAbsent(
          id,
          () => CartModel(
              id: DateTime.now().toString(),
              price: price,
              quantity: 1,
              title: title));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void undoTheAdditionToCart(String id) {
    if (!_cartItems.containsKey(id)) {
      return;
    }
    if (_cartItems[id].quantity > 1) {
      _cartItems.update(
          id,
          (oldItem) => CartModel(
              id: oldItem.id,
              title: oldItem.title,
              price: oldItem.price,
              quantity: oldItem.quantity - 1)
          );
    }else{
      _cartItems.remove(id);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }
}
