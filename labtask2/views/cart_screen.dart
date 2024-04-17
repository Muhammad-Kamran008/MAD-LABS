import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedProducts =
        ModalRoute.of(context)!.settings.arguments as List<Product>;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Cart',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedProducts.length,
              itemBuilder: (_, index) {
                final product = selectedProducts[index];
                final nameWords = product.title.split(' ');
                final firstFourWords = nameWords.take(4).join(' ');
                return ListTile(
                  title: Text(
                    '${index + 1} - $firstFourWords',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 4,
          ),
          Container(
            padding: const EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${selectedProducts.fold<double>(0, (sum, product) => sum + product.price).toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.w900),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Buy',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
