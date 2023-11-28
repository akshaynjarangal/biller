import 'dart:convert';
import 'dart:developer';

import 'package:biller/src/constants/app_url.dart';
import 'package:biller/src/data/service/abstraction/order_service.dart';
import 'package:http/http.dart' as http;

class OrderImpl implements OrderService {
  @override
  Future<bool> placeOrder(Map<String, dynamic> order) async {
    try {
      final uri = Uri.http(AppUrls.ip, AppUrls.ordersEndPoint);
      final res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(order),
      );
      log("STATUS ORDER ---->${res.body}-----${res.statusCode}");
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
