part of 'place_order_bloc.dart';

sealed class PlaceOrderEvent extends Equatable {
  const PlaceOrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends PlaceOrderEvent {
  final Map<String, dynamic> order;
  const PlaceOrder({required this.order});
}