part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();
  
  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsFailed extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductListModel> products;

  const ProductsSuccess({required this.products});
}
