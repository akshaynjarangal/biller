class AppUrls {
  static const String ip = '62.72.44.247';
  static const String base = '/api';
  static const String productsEndPoint = '$base/products';
  static const String customersEndPoint = '$base/customers/';
  static const String ordersEndPoint = '$base/orders/';

  static String imagePath(String endPoint) => Uri.http(ip,endPoint).toString();
}