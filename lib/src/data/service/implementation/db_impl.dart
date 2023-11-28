import 'package:biller/src/data/models/cart_product_model.dart';
import 'package:biller/src/data/models/customers_list_model.dart';
import 'package:biller/src/data/models/product_list_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../abstraction/db_service.dart';

class DBImpl implements DBService {
  @override
  void registerAdapter() {
    
      if (!Hive.isAdapterRegistered(ProductListModelAdapter().typeId)) {
        Hive.registerAdapter(ProductListModelAdapter());
      }
      if(!Hive.isAdapterRegistered(CustomersListModelAdapter().typeId)){
        Hive.registerAdapter(CustomersListModelAdapter());
      }
      if(!Hive.isAdapterRegistered(CartProductModelAdapter().typeId)){
        Hive.registerAdapter(CartProductModelAdapter());
      }
  }
}