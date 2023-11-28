part of 'place_order_bloc.dart';

sealed class PlaceOrderState extends Equatable {
  const PlaceOrderState();
  
  @override
  List<Object> get props => [];
}

final class PlaceOrderInitial extends PlaceOrderState {}

final class PlaceOrderLoading extends PlaceOrderState {}

final class PlaceOrderSuccess extends PlaceOrderState {
  final String message;
  const PlaceOrderSuccess({required this.message});
}

final class PlaceOrderFailure extends PlaceOrderState {
  final String message;
  const PlaceOrderFailure({required this.message});
}