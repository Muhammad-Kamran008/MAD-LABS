import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mad_lab08/models/product.dart';

class ProductService {
  static Future<List<Product>> getProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'  ));
    var ress = response.statusCode;
    if (kDebugMode) {
      print("Response is: $ress ");
    }

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Product> products =
          data.map((item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
