import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:biller/src/constants/app_url.dart';
import 'package:biller/src/data/models/customers_list_model.dart';
import 'package:biller/src/data/service/abstraction/customers_service.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class CustomersImpl implements CustomersService {
  @override
  Future<List<CustomersListModel>> getCustomers() async {
    try {
      final uri = Uri.http(AppUrls.ip, AppUrls.customersEndPoint);
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        final data = (decoded['data'] as List)
            .map((e) => CustomersListModel.fromJson(e))
            .toList();
        final box = await Hive.openBox<CustomersListModel>('customers_db');
        await box.clear();
        log("CLEAR LIST ----->${box.values.length}");
        for (var element in data) {
          final imageResponse = await http
              .get(Uri.parse(AppUrls.imagePath(element.profilePic ?? "")));
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
      log("Customers from DB");
      final box = await Hive.openBox<CustomersListModel>('customers_db');
      final dbdata = box.values.toList();
      log(dbdata.length.toString());
      return dbdata;
    }
  }

  @override
  Future<bool> createCustomer(
      {required Map<String, String> customer, required File path,}) async {
    try {
      final uri = Uri.http(AppUrls.ip, AppUrls.customersEndPoint);
      final request = http.MultipartRequest('POST', uri);
      request.fields.addAll(customer);
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_pic',
          path.path,
        ),
      );

      http.StreamedResponse response = await request.send();
      log("PAAPAP ----->${jsonEncode(customer)}");
      log("IMG ----->${await response.stream.bytesToString()}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
