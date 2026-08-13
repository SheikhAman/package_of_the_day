import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  // 🧩 Reactive List (.obs)
  // GetX will track every change to this list automatically.
  final cartItems = <Product>[].obs;

  // 🧩 Computed Properties (Derived State)
  // These update automatically whenever 'cartItems' changes.
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);
  int get itemCount => cartItems.length;

  void addToCart(Product product) {
    cartItems.add(product);

    // GetX Feature: Context-less Snackbar
    Get.snackbar(
      'Added to Cart',
      '${product.name} is now in your basket',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6366F1),
      colorText: Colors.white,
      margin: const EdgeInsets.all(20),
      borderRadius: 16,
      icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
      duration: const Duration(seconds: 1),
    );
  }

  void clearCart() => cartItems.clear();
}
