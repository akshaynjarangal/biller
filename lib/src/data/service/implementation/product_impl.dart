import 'dart:convert';
import 'dart:developer';
import 'package:biller/src/constants/app_url.dart';
import 'package:biller/src/data/models/product_list_model.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../abstraction/products_service.dart';

class ProductsImple extends ProductService {
  @override
  Future<List<ProductListModel>> getProducts() async {
    try {
      final uri = Uri.http(AppUrls.ip, AppUrls.productsEndPoint);
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        final data = (decoded['data'] as List)
            .map((e) => ProductListModel.fromJson(e))
            .toList();
        final box = await Hive.openBox<ProductListModel>('products_db');
        await box.clear();
        log("CLEAR LIST ----->${box.values.length}");
        for (var element in data) {
          final imageResponse =
          await http.get(Uri.parse(AppUrls.imagePath(element.image ?? "")));
          if (imageResponse.statusCode == 200) {
            final imageBytes = Uint8List.fromList(imageResponse.bodyBytes);
            element = element.copyWith(imageBytes: imageBytes);
          }
          await box.add(element);
        }
        log("----->====== Length  ${box.values.length}");
        return box.values.toList();
      } else {
        return [];
      }
    } catch (e) {
      log("Product from DB");
      final box = await Hive.openBox<ProductListModel>('products_db');
      final dbdata = box.values.toList();
      log(dbdata.length.toString());
      return dbdata;
    }
  }
}
