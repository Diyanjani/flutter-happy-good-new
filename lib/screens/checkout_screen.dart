import 'package:flutter/material.dart';
import 'cart_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  String paymentMethod = 'Cash';

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController securityCodeController = TextEditingController();
  final TextEditingController nameOnCardController = TextEditingController();

  double get totalAmount {
    return CartScreen.cartItems.values.fold(0.0, (sum, item) {
      final product = item['product'] as Product;
      final quantity = item['quantity'] as int;
      return sum + (product.price * quantity);
    });
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartScreen.cartItems;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Shipping Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              TextFormField(
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: _requiredValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: _requiredValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: _requiredValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: _requiredValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City'),
                validator: _requiredValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Postal Code'),
                validator: _requiredValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: _requiredValidator,
              ),

              const SizedBox(height: 20),
              const Text(
                "Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: paymentMethod,
                items:
                    ['Cash', 'Credit Card', 'Debit Card'].map((method) {
                      return DropdownMenuItem<String>(
                        value: method,
                        child: Text(method),
                      );
                    }).toList(),
                onChanged: (value) => setState(() => paymentMethod = value!),
              ),

              if (paymentMethod != 'Cash') ...[
                TextFormField(
                  controller: cardNumberController,
                  decoration: const InputDecoration(labelText: 'Card Number'),
                  validator: _requiredValidator,
                ),
                TextFormField(
                  controller: expiryDateController,
                  decoration: const InputDecoration(labelText: 'Expiry Date'),
                  validator: _requiredValidator,
                ),
                TextFormField(
                  controller: securityCodeController,
                  decoration: const InputDecoration(labelText: 'Security Code'),
                  validator: _requiredValidator,
                ),
                TextFormField(
                  controller: nameOnCardController,
                  decoration: const InputDecoration(labelText: 'Name on Card'),
                  validator: _requiredValidator,
                ),
              ],

              const SizedBox(height: 20),
              const Text(
                "Order Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              ...cartItems.entries.map((entry) {
                final product = entry.value['product'] as Product;
                final quantity = entry.value['quantity'] as int;
                final total = product.price * quantity;

                return ListTile(
                  title: Text('${product.name} x$quantity'),
                  trailing: Text('\$${total.toStringAsFixed(2)}'),
                );
              }).toList(),

              const Divider(),
              ListTile(
                title: const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text('\$${totalAmount.toStringAsFixed(2)}'),
              ),
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Order Placed Successfully!'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Pay Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
