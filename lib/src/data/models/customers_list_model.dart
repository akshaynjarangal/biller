// To parse this JSON data, do
//
//     final customersListModel = customersListModelFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'customers_list_model.g.dart';

List<CustomersListModel> customersListModelFromJson(String str) =>
    List<CustomersListModel>.from(
      json.decode(str).map((x) => CustomersListModel.fromJson(x)),
    );

String customersListModelToJson(List<CustomersListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class CustomersListModel extends Equatable {
  @HiveField(1)
  final int? id;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final String? profilePic;
  @HiveField(4)
  final String? mobileNumber;
  @HiveField(5)
  final String? email;
  @HiveField(6)
  final String? street;
  @HiveField(7)
  final String? streetTwo;
  @HiveField(8)
  final String? city;
  @HiveField(9)
  final int? pincode;
  @HiveField(10)
  final String? country;
  @HiveField(11)
  final String? state;
  @HiveField(12)
  final DateTime? createdDate;
  @HiveField(13)
  final String? createdTime;
  @HiveField(14)
  final DateTime? modifiedDate;
  @HiveField(15)
  final String? modifiedTime;
  @HiveField(16)
  final bool? flag;
  @HiveField(17)
  final Uint8List? imageBytes;

  const CustomersListModel({
    this.id,
    this.name,
    this.profilePic,
    this.mobileNumber,
    this.email,
    this.street,
    this.streetTwo,
    this.city,
    this.pincode,
    this.country,
    this.state,
    this.createdDate,
    this.createdTime,
    this.modifiedDate,
    this.modifiedTime,
    this.flag,
    this.imageBytes,
  });

  CustomersListModel copyWith({
    int? id,
    String? name,
    String? profilePic,
    String? mobileNumber,
    String? email,
    String? street,
    String? streetTwo,
    String? city,
    int? pincode,
    String? country,
    String? state,
    DateTime? createdDate,
    String? createdTime,
    DateTime? modifiedDate,
    String? modifiedTime,
    bool? flag,
    Uint8List? imageBytes,
  }) =>
      CustomersListModel(
        id: id ?? this.id,
        name: name ?? this.name,
        profilePic: profilePic ?? this.profilePic,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        email: email ?? this.email,
        street: street ?? this.street,
        streetTwo: streetTwo ?? this.streetTwo,
        city: city ?? this.city,
        pincode: pincode ?? this.pincode,
        country: country ?? this.country,
        state: state ?? this.state,
        createdDate: createdDate ?? this.createdDate,
        createdTime: createdTime ?? this.createdTime,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedTime: modifiedTime ?? this.modifiedTime,
        flag: flag ?? this.flag,
        imageBytes: imageBytes ?? this.imageBytes,
      );

  factory CustomersListModel.fromJson(Map<String, dynamic> json) =>
      CustomersListModel(
        id: json["id"],
        name: json["name"],
        profilePic: json["profile_pic"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        street: json["street"],
        streetTwo: json["street_two"],
        city: json["city"],
        pincode: json["pincode"],
        country: json["country"],
        state: json["state"],
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
        "profile_pic": profilePic,
        "mobile_number": mobileNumber,
        "email": email,
        "street": street,
        "street_two": streetTwo,
        "city": city,
        "pincode": pincode,
        "country": country,
        "state": state,
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
        profilePic,
        mobileNumber,
        email,
        street,
        streetTwo,
        city,
        pincode,
        country,
        state,
        createdDate,
        createdTime,
        modifiedDate,
        modifiedTime,
        flag,
        imageBytes,
      ];
}
