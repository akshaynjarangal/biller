import 'package:biller/src/data/models/product_list_model.dart';


abstract class ProductService {
  Future<List<ProductListModel>> getProducts ();
}

