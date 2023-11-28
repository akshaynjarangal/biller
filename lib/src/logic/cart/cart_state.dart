part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState({required this.cartProducts, required this.cartTotal});
  final List<CartProductModel> cartProducts;
  final int cartTotal;
  @override
  List<Object> get props => [identityHashCode(this)];
}

final class CartInitial extends CartState {
  final List<CartProductModel> list;
  final int totalAmount;
  const CartInitial({required this.list, required this.totalAmount})
      : super(cartProducts: list, cartTotal: totalAmount);
}
