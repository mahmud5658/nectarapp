import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import '../infrastructure.dart';

class ProductLocalDb implements IProductDatabase {
  ProductLocalDb._(this.user);

  final UserModel user;

  static Future<IProductDatabase> create(UserModel user) async {
    user = user;
    final repo = ProductLocalDb._(user);

    return repo;
  }

  @override
  Future<ProductModel> addToCart(ProductModel model) async {
    //call server
    return model;
  }

  @override
  Future<ProductModel> addOnSaved(ProductModel model) async {
    return model.copyWith(isSaved: true);
  }

  @override
  Future<ProductModel> removeFromSaved(ProductModel model) async {
    return model.copyWith(isSaved: false);
  }

  @override
  Future<ProductState> getProducts(ProductParam param) async {
    final response = await rootBundle.loadString("assets/json/products.json");
    final decodedData = jsonDecode(response);
    final data = decodedData['data'] as List;
    final totalItems = decodedData['total_item'] ?? 0;
    final fetchItems = List<ProductModel>.from(data.map((e) => ProductModel.fromMap(e)));

    return ProductState(
      data: fetchItems,
      totalItem: totalItems,
      filterData: fetchItems,
    );
  }
}
