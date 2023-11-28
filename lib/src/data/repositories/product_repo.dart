
import 'package:biller/src/data/models/product_list_model.dart';
import 'package:biller/src/data/service/abstraction/products_service.dart';

class ProductRepo {
  final ProductService _productService;
  ProductRepo({required ProductService productService}) : _productService = productService;

  Future<List<ProductListModel>> getProducts() async {
    return _productService.getProducts();
  }
}