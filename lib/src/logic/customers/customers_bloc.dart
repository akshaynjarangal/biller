import 'dart:io';

import 'package:biller/src/data/models/customers_list_model.dart';
import 'package:biller/src/data/repositories/customers_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final CustomersRepo _customersRepo;
  CustomersBloc(this._customersRepo) : super(CustomersInitial()) {
    on<FetchCustomersEvent>((event, emit) async{
      emit(const CustomersLoading(isCreating: false));
      final res = await _customersRepo.getCustomers();
      if(res.isNotEmpty){
        emit(CustomersSuccess(customers: res));
      }else{
        emit(CustomersFailed());
      }
    });

    on<CreateCustomerEvent>((event, emit) async{
      emit(const CustomersLoading(isCreating: true));
      final res = await _customersRepo.createCustomer(customer: event.customer, path: event.path);
      if(res){
        add(FetchCustomersEvent());
      }else{
        emit(CustomersFailed());
      }
    });
  }
}
