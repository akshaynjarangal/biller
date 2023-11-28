import 'package:biller/src/data/models/cart_product_model.dart';
import 'package:biller/src/data/service/abstraction/cart_db_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartDBImpl implements CartDBService {

  @override
  Future<void> deleteFromCart(int key) async {
    final box = await Hive.openBox<CartProductModel>('cart_db');
    await box.delete(key);
  }

  @override
  Future<List<CartProductModel>> getAllCart() async {
    final box = await Hive.openBox<CartProductModel>('cart_db');
    return box.values.toList();
  }

  @override
  Future<void> addToCart(CartProductModel product) async {
    final box = await Hive.openBox<CartProductModel>('cart_db');
    final val = await box.add(product);
    final res = box.get(val);
    if (res != null) {
      await box.put(val, res.copyWith(id: val));
    }
  }

  @override
  Future<void> updateCart(int key, bool isIncrement) async {
    final box = await Hive.openBox<CartProductModel>('cart_db');
    final res = box.get(key);
    if (res != null) {
      if (res.quantity == 1 && !isIncrement) {
        await box.delete(key);
      } else {
        await box.put(
          key,
          res.copyWith(
            quantity: isIncrement ? res.quantity! + 1 : res.quantity! - 1,
          ),
        );
      }
    }
  }
  
  @override
  Future<void> deleteAllFromCart() async{
    final box = await Hive.openBox<CartProductModel>('cart_db');
    final list = box.values.toList();
    await box.deleteAll(list.map((e) => e.id).toList());
  }
}
