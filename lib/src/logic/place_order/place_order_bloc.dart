import 'package:biller/src/data/repositories/order_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'place_order_event.dart';
part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  final OrderRepo _orderRepo;

  PlaceOrderBloc(this._orderRepo) : super(PlaceOrderInitial()) {
    on<PlaceOrder>((event, emit) async {
      emit(PlaceOrderLoading());
      final res = await _orderRepo.placeOrder(event.order);
      if (res) {
        emit(const PlaceOrderSuccess(message: 'Order Placed Successfully'));
      } else {
        emit(const PlaceOrderFailure(message: 'Order Placed Failed'));
      }
    });
  }
}
