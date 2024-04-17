import 'package:flutter/material.dart';
import 'package:mad_lab08/views/cart_screen.dart';
import 'package:mad_lab08/views/catalog_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab_8 Task_03',
      theme: ThemeData(
          // primarySwatch: Colors.yellow,
          ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CatalogScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
