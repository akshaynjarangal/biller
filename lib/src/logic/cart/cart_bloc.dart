import 'dart:developer';

import 'package:biller/src/data/models/cart_product_model.dart';
import 'package:biller/src/data/repositories/cart_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo _cartRepo;
  CartBloc(this._cartRepo)
      : super(const CartInitial(list: [], totalAmount: 0)) {
    on<AddToCart>((event, emit) async {
      await _cartRepo.addProductToCart(product: event.cartProductModel);
      add(FetchCart());
    });

    on<FetchCart>((event, emit) async {
      final res = await _cartRepo.getCartProducts();
      log("DATABASSE LENGTH------->${res.length}");
      if (res.isEmpty) {
        emit(const CartInitial(list: [], totalAmount: 0));
      } else {
        num total = 0;
        for (var product in res) {
          int quantity = product.quantity!;
          num price = product.price!;
          total += quantity * price;
          emit(CartInitial(list: res, totalAmount: total.toInt()));
        }
      }
    });

    on<UpdateCart>((event, emit) {
      _cartRepo.updateCart(key: event.key, isIncrement: event.isIncrement);
      add(FetchCart());
    });

    on<RemoverFromCart>((event, emit) {
      _cartRepo.deleteFromCart(key: event.key);
      add(FetchCart());
    });

    on<ClearCart>((event, emit) {
      _cartRepo.deleteAllFromCart();
      add(FetchCart());
    });
  }
}
