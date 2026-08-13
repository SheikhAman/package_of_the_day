import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';

const _accent = Color(0xFF6366F1);

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection: Find or create our controller
    final CartController controller = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 101 - GetX Cart',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: controller.clearCart,
            icon: const Icon(Icons.delete_sweep_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Reactive Header Card ──
          // Obx only rebuilds what's inside it. High performance!
          Obx(() => _buildSummaryCard(controller)),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'PREMIUM INVENTORY',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Colors.black26,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),

          // ── Product Feed ──
          Expanded(child: _buildProductFeed(controller)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(CartController controller) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [_accent, Color(0xFF4F46E5)]),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: _accent.withValues(alpha: 0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'CURRENT BALANCE',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '\$${controller.totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${controller.itemCount} ITEMS READY FOR CHECKOUT',
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductFeed(CartController controller) {
    final products = [
      Product(id: '1', name: 'MacBook Pro M3', price: 1999.00),
      Product(id: '2', name: 'iPhone 15 Pro', price: 999.00),
      Product(id: '3', name: 'Studio Display', price: 1599.00),
      Product(id: '4', name: 'AirPods Max', price: 549.00),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final p = products[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              child: Icon(Icons.devices_rounded, color: _accent, size: 20),
            ),
            title: Text(
              p.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '\$${p.price}',
              style: const TextStyle(
                color: _accent,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: IconButton.filledTonal(
              onPressed: () => controller.addToCart(p),
              icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
            ),
          ),
        );
      },
    );
  }
}
