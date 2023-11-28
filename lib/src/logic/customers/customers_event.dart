part of 'customers_bloc.dart';

sealed class CustomersEvent extends Equatable {
  const CustomersEvent();

  @override
  List<Object> get props => [];
}

final class FetchCustomersEvent extends CustomersEvent {}

final class CreateCustomerEvent extends CustomersEvent {
  final Map<String, String> customer;
  final File path;
  const CreateCustomerEvent({required this.customer,required this.path});
}