import 'package:flutter/material.dart';
import 'package:flutter_furniture_app/model/model.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + (item.price));
  }

  double get totalOriginalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + (item.priceWas));
  }

  double get totalSavings {
    return _cartItems.fold(0.0, (sum, item) => sum + ((item.priceWas) - (item.price)));
  }
}
