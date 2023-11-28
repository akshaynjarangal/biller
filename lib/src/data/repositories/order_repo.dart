import 'package:biller/src/data/service/abstraction/order_service.dart';

class OrderRepo {
  final OrderService _orderService;
  OrderRepo({required OrderService orderService})
      : _orderService = orderService;

  Future<bool> placeOrder(Map<String, dynamic> order) async {
    return _orderService.placeOrder(order);
  }
}
