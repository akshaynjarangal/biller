part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final CartProductModel cartProductModel;
  const AddToCart({required this.cartProductModel});
}

class FetchCart extends CartEvent {}

class UpdateCart extends CartEvent {
  final int key;
  final bool isIncrement;
  const UpdateCart({required this.key, required this.isIncrement});
}

class RemoverFromCart extends CartEvent {
  final int key;
  const RemoverFromCart({required this.key});
}

class ClearCart extends CartEvent {}