import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/cart_view.dart';

class Day101Get extends StatelessWidget {
  const Day101Get({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CartView(),
    );
  }
}
