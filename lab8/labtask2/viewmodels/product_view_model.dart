import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mad_lab08/models/product.dart';
import 'package:http/http.dart' as http;

class ProductViewModel extends Cubit<Object> {
  ProductViewModel() : super([]);

  List<Product> get products => state as List<Product>;

  Future<void> loadProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final dynamic jsonList = json.decode(response.body);
      if (jsonList is List) {
        final List<Product> productList =
            jsonList.map((dynamic json) => Product.fromJson(json)).toList();
        emit(productList);
      } else {
        throw Exception('Failed to load products');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
