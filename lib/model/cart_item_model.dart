import 'package:flutter_fake_store_api/model/product_model.dart';

class CartItemModel {
  int quantity;
  ProductModel product;
  CartItemModel({
    this.quantity = 1,
    required this.product,
  });
}
