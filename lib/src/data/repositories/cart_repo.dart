import 'package:biller/src/data/models/cart_product_model.dart';
import 'package:biller/src/data/service/abstraction/cart_db_service.dart';

class CartRepo {
  final CartDBService _cartDBService;
  CartRepo({required CartDBService cartDBService}) : _cartDBService = cartDBService;

  Future<void> addProductToCart({required CartProductModel product}) async {
    return _cartDBService.addToCart(product);
  }

  Future<List<CartProductModel>> getCartProducts() async {
    return _cartDBService.getAllCart();
  }

  Future<void> updateCart({required int key, required bool isIncrement}) async {
    return _cartDBService.updateCart(key, isIncrement);
  }

  Future<void> deleteFromCart({required int key}) async {
    return _cartDBService.deleteFromCart(key);
  }

  Future<void> deleteAllFromCart() async{
    return _cartDBService.deleteAllFromCart();
  }
}