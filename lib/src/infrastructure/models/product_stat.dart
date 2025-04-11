import 'package:equatable/equatable.dart';

import '../infrastructure.dart';

class ProductParam {
  const ProductParam({
    this.page = 1,
    this.limit = 25,
    this.foodCategory,
    this.isFavorite = false,
    this.isMyCart = false,
  });

  final int page;
  final int limit;
  final String? foodCategory;
  final bool isFavorite;
  final bool isMyCart;
}

class ProductState extends Equatable {
  const ProductState({
    required this.data,
    required this.totalItem,
    required this.filterData,
  });

  static const ProductState none = ProductState(data: [], totalItem: 0, filterData: []);

  final List<ProductModel> data;
  final List<ProductModel> filterData;
  final int totalItem;

  ProductState copyWith({
    List<ProductModel>? data,
    List<ProductModel>? filterData,
    int? totalItem,
  }) {
    return ProductState(
      data: data ?? this.data,
      filterData: filterData ?? this.filterData,
      totalItem: totalItem ?? this.totalItem,
    );
  }

  @override
  List<Object?> get props => [data, filterData, totalItem];
}
