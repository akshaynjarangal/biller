part of 'customers_bloc.dart';

sealed class CustomersState extends Equatable {
  const CustomersState();
  
  @override
  List<Object> get props => [];
}

final class CustomersInitial extends CustomersState {}

final class CustomersLoading extends CustomersState {
  final bool isCreating;
  const CustomersLoading({required this.isCreating});
}

final class CustomersSuccess extends CustomersState {
  final List<CustomersListModel> customers;

  const CustomersSuccess({required this.customers});
}

final class CustomersFailed extends CustomersState {}
