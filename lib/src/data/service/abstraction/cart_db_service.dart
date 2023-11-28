import 'package:biller/src/data/models/cart_product_model.dart';

abstract class CartDBService {
  Future<void> addToCart(CartProductModel cart);

  Future<void> updateCart(int key,bool isIncrement);

  Future<void> deleteFromCart(int key);

  Future<void> deleteAllFromCart();

  Future<List<CartProductModel>> getAllCart();

}
