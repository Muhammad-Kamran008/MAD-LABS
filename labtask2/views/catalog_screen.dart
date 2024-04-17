import 'package:flutter/material.dart';
import 'package:mad_lab08/models/product.dart';
import 'package:mad_lab08/services/product_service.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  CatalogScreenState createState() => CatalogScreenState();
}

class CatalogScreenState extends State<CatalogScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await ProductService.getProducts();
    setState(() {
      _products = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Catalog',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900
                // Set the text color to black
                ),
          ),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              final selectedProducts =
                  _products.where((product) => product.isSelected).toList();
              Navigator.pushNamed(context, '/cart',
                  arguments: selectedProducts);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: ProductService.getProducts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: _products.length,
                itemBuilder: (_, index) {
                  final product = _products[index];
                  final nameWords = product.title.split(' ');
                  final firstFourWords = nameWords.take(4).join(' ');
                  return ListTile(
                    title: Text(firstFourWords),
                    leading: Image.network(
                      product.image,
                      width: 40,
                      height: 40,
                    ),
                    trailing: InkWell(
                      onTap: () {
                        setState(() {
                          product.isSelected = !product.isSelected;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            product.isSelected
                                ? const Icon(Icons.check, color: Colors.green)
                                : const SizedBox(),
                            const SizedBox(width: 2),
                            Text(
                              product.isSelected ? '' : 'Add',
                              style: TextStyle(
                                color: product.isSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No products found.'),
              );
            }
          },
        ),
      ),
    );
  }
}
