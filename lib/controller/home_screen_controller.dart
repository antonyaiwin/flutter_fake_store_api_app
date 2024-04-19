import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fake_store_api/model/product_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends ChangeNotifier {
  List<ProductModel> productList = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      Uri uri = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(uri);

      if (response.statusCode >= 200 || response.statusCode < 300) {
        productList = productModelListFromJson(response.body);
      } else {
        log('failed to fetch data');
      }
    } on Exception catch (e) {
      log('failed with exception : $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
