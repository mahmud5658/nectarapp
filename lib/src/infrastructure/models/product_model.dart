
import 'package:equatable/equatable.dart';

import '../enums/product_filter.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.type,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.isSaved,
    this.reviewCounter = 0,
    required this.description,
    required this.deliveryTime,
    this.orderCounter = 0,
    this.unit = "per kg",
  });
  static const imagePath = "https://avatars.githubusercontent.com/u/46500228?v=4";

  static ProductModel get ui => ProductModel(
        id: 0,
        type: ProductType.fruits,
        name: "Orange",
        price: 6.0,
        rating: 3.5,
        imageUrl: imagePath,
        isSaved: false,
        reviewCounter: 4500,
        description: "This is a product desc" * 33,
        deliveryTime: "30-35 minutes",
        orderCounter: 1,
      );

  final int id;
  final ProductType type;
  final String name;
  final double price;
  final double rating;
  final String imageUrl;
  final bool isSaved;
  final int reviewCounter;
  final String description;
  final String deliveryTime;
  final int orderCounter;
  final String unit;

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      type: ProductType.fromMap(map['type']),
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      rating: map['rating']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      isSaved: map['isSaved'] ?? false,
      reviewCounter: map['review_counter']?.toInt() ?? 0,
      description: map['description'] ?? '',
      deliveryTime: map['delivery_time'] ?? '',
      orderCounter: map['order_counter']?.toInt() ?? 0,
      unit: map['unit'] ?? '',
    );
  }

  ProductModel copyWith({
    int? id,
    ProductType? type,
    String? name,
    double? price,
    double? rating,
    String? imageUrl,
    bool? isSaved,
    int? reviewCounter,
    String? description,
    String? deliveryTime,
    int? orderCounter,
    String? unit,
  }) {
    return ProductModel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isSaved: isSaved ?? this.isSaved,
      reviewCounter: reviewCounter ?? this.reviewCounter,
      description: description ?? this.description,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      orderCounter: orderCounter ?? this.orderCounter,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props =>
      [id, type, name, price, rating, imageUrl, isSaved, reviewCounter, description, deliveryTime, orderCounter, unit];
}
