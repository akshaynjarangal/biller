// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);
import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'product_list_model.g.dart';

List<ProductListModel> productListModelFromJson(String str) =>
    List<ProductListModel>.from(
      json.decode(str).map((x) => ProductListModel.fromJson(x)),
    );

String productListModelToJson(List<ProductListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class ProductListModel extends Equatable {
  @HiveField(1)
  final int? id;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final int? price;
  @HiveField(5)
  final DateTime? createdDate;
  @HiveField(6)
  final String? createdTime;
  @HiveField(7)
  final DateTime? modifiedDate;
  @HiveField(8)
  final String? modifiedTime;
  @HiveField(9)
  final bool? flag;
  @HiveField(10)
  final Uint8List? imageBytes;

  const ProductListModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.createdDate,
    this.createdTime,
    this.modifiedDate,
    this.modifiedTime,
    this.flag,
    this.imageBytes,
  });

  ProductListModel copyWith({
    int? id,
    String? name,
    String? image,
    int? price,
    DateTime? createdDate,
    String? createdTime,
    DateTime? modifiedDate,
    String? modifiedTime,
    bool? flag,
    Uint8List? imageBytes,
  }) =>
      ProductListModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
        createdDate: createdDate ?? this.createdDate,
        createdTime: createdTime ?? this.createdTime,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedTime: modifiedTime ?? this.modifiedTime,
        flag: flag ?? this.flag,
        imageBytes: imageBytes ?? this.imageBytes,
      );

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "created_date":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date":
            "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        price,
        createdDate,
        createdTime,
        modifiedDate,
        modifiedTime,
        flag,
        imageBytes,
      ];
}
