import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class Product {
  final String name;
  final String image;
  final double price;

  Product({required this.name, required this.image, required this.price});
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static final Map<String, Map<String, dynamic>> _cart = {};

  static void addToCart(Product product, int quantity) {
    if (_cart.containsKey(product.name)) {
      _cart[product.name]!['quantity'] += quantity;
    } else {
      _cart[product.name] = {'product': product, 'quantity': quantity};
    }
  }

  static Map<String, Map<String, dynamic>> get cartItems => _cart;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartScreen._cart.values.toList();

    double totalAmount = 0;
    for (var item in cartItems) {
      final product = item['product'] as Product;
      final quantity = item['quantity'] as int;
      totalAmount += product.price * quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen[200],
      ),
      body:
          cartItems.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartItems[index]['product'] as Product;
                  final quantity = cartItems[index]['quantity'] as int;
                  final total = product.price * quantity;

                  return ListTile(
                    leading: Image.asset(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Text(
                      'Quantity: $quantity\nTotal: Rs. ${total.toStringAsFixed(2)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          CartScreen._cart.remove(product.name);
                        });
                      },
                    ),
                  );
                },
              ),
      bottomNavigationBar:
          cartItems.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total Amount: Rs. ${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Text('Checkout'),
                      ),
                    ),
                  ],
                ),
              )
              : null,
    );
  }
}
