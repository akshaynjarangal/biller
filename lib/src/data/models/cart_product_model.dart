// To parse this JSON data, do
//
//     final cartProductModel = cartProductModelFromJson(jsonString);

import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_product_model.g.dart';

List<CartProductModel> cartProductModelFromJson(String str) =>
    List<CartProductModel>.from(
      json.decode(str).map((x) => CartProductModel.fromJson(x)),
    );

String cartProductModelToJson(List<CartProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 3)
class CartProductModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int? productId;
  @HiveField(2)
  final int? quantity;
  @HiveField(3)
  final int? price;
  @HiveField(4)
  final String? name;

  const CartProductModel({
    this.id,
    this.productId,
    this.quantity,
    this.price,
    this.name,
  });

  CartProductModel copyWith({
    int? id,
    int? productId,
    int? quantity,
    int? price,
    String? name,
  }) =>
      CartProductModel(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        name: name ?? this.name,
      );

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "price": price,
      };
}
