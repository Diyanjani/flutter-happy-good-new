import 'package:flutter/material.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String imagePath;
  final String name;
  final double price;

  const ProductDetailsScreen({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  void increment() => setState(() => quantity++);
  void decrement() {
    if (quantity > 1) setState(() => quantity--);
  }

  final Map<String, String> descriptions = {
    'Carrot': 'Rich in beta-carotene and great for eyesight and skin health.',
    'Beans': 'Fresh green beans packed with fiber and essential nutrients.',
    'Beetroot': 'A natural detoxifier and great for boosting stamina.',
    'Brinjal': 'Soft and flavorful, ideal for curries and grilling.',
    'Pumpkin': 'Nutritious and rich in vitamins A and C.',
    'Tomato': 'Juicy and full of antioxidants like lycopene.',
    'Potato': 'Versatile and filling, a staple in many dishes.',
    'Onions': 'Essential in every kitchen for flavor and aroma.',
    'Apple': 'Crunchy, sweet, and perfect for a healthy snack.',
    'Banana': 'High in potassium and a quick energy booster.',
    'Grapes': 'Juicy, sweet, and rich in antioxidants.',
    'Guava': 'Loaded with vitamin C and fiber.',
    'Oranges': 'Citrusy and refreshing, a great source of vitamin C.',
    'Pineapple': 'Tropical fruit known for its sweet and tangy flavor.',
    'Strawberry': 'Bright red and sweet, a perfect dessert fruit.',
    'Watermelon': 'Hydrating and sweet, perfect for summer.',
    'Butter': 'Creamy and rich, perfect for baking and cooking.',
    'Cheese': 'Delicious dairy full of calcium and protein.',
    'Curd': 'Great for digestion and gut health.',
    'Freshmilk': 'Pure and natural milk rich in calcium.',
    'Icecream': 'Sweet and cold, the ultimate treat.',
    'Chocolate Milk Packet': 'Daily dairy essential for growing kids.',
    'Vanilla Milk Packet': 'Flavored milk that’s creamy and satisfying.',
    'Yogurt': 'Tasty probiotic snack for better digestion.',
    'Beef': 'Tender and protein-rich red meat.',
    'Boneless Chicken': 'Lean and easy-to-cook protein source.',
    'Chicken': 'Versatile and tasty meat for any recipe.',
    'Chicken Leg': 'Juicy and flavorful, perfect for grilling.',
    'Fish': 'Rich in omega-3 fatty acids and high-quality protein.',
    'Pork': 'Savory and tender, best for roasts and stir-fries.',
    'Pork Sausages': 'Spicy and filling, ideal for breakfast.',
    'Sausages': 'Quick-to-cook and flavorful meat option.',
    'Coca-cola': 'Classic fizzy drink loved worldwide.',
    'Cream Soda': 'Sweet and smooth carbonated beverage.',
    'Fanta': 'Fruity and fizzy, a refreshing soda.',
    '7UP': 'Lemon-lime soda with a crisp taste.',
    'EGB': 'Ginger-based beverage with a spicy kick.',
    'Redbull': 'Energy drink to boost alertness and performance.',
    'Sprite': 'Crisp, clean lemon-lime soda.',
    'Suncrush': 'Tropical soft drink with a sweet twist.',
    'Ayush Facewash': 'Ayurvedic shampoo for healthy and strong hair.',
    'Skin Toner': 'Refreshes skin and tightens pores.',
    'Face Cream': 'Moisturizes and softens the skin.',
    'Mens Facewash': 'Cleanses dirt and excess oil gently.',
    'Lipbalm': 'Keeps your lips soft and moisturized.',
    'Glow and Lovely': 'Fragrance-infused lotion for smooth skin.',
    'Vivya facewash': 'Gentle skincare solution for daily use.',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    String description =
        descriptions[widget.name] ??
        "This is a detailed description of the product.";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: isDark ? Colors.black : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(widget.imagePath, height: 250, fit: BoxFit.cover),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(description, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Price: Rs. ${widget.price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text('Quantity: ', style: TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: decrement,
                  icon: const Icon(Icons.remove),
                ),
                Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
                IconButton(onPressed: increment, icon: const Icon(Icons.add)),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final product = Product(
                  name: widget.name,
                  image: widget.imagePath,
                  price: widget.price,
                );
                CartScreen.addToCart(product, quantity);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${widget.name} added to cart')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen[200],
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
