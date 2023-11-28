import 'package:biller/src/data/models/product_list_model.dart';
import 'package:biller/src/data/repositories/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepo _productRepo;
  ProductsBloc(this._productRepo) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      final resp = await _productRepo.getProducts();
      if(resp.isNotEmpty){
        emit(ProductsSuccess(products: resp));
      }else{
        emit(ProductsFailed());
      }
    });
  }
}
