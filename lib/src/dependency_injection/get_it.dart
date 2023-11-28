import 'package:biller/src/data/repositories/cart_repo.dart';
import 'package:biller/src/data/repositories/order_repo.dart';
import 'package:biller/src/data/service/abstraction/cart_db_service.dart';
import 'package:biller/src/data/service/abstraction/order_service.dart';
import 'package:biller/src/data/service/implementation/cart_db_impl.dart';
import 'package:biller/src/data/service/implementation/order_impl.dart';
import 'package:biller/src/logic/cart/cart_bloc.dart';
import 'package:biller/src/logic/place_order/place_order_bloc.dart';

import 'di.dart';

// Initialize GetIt
GetIt getIt = GetIt.instance;

void setupDependencies() {
  //Database Instance
  getIt.registerLazySingleton<DBService>(() => DBImpl());
  getIt.registerLazySingleton<DBRepository>(
    () => DBRepository(dbService: getIt<DBService>()),
  );

  //Products Instance
  getIt.registerLazySingleton<ProductService>(
    () => ProductsImple(),
  );
  getIt.registerLazySingleton<ProductRepo>(
    () => ProductRepo(productService: getIt<ProductService>()),
  );
  getIt.registerFactory<ProductsBloc>(() => ProductsBloc(getIt<ProductRepo>()));

//CUSTOMERS Instance
  getIt.registerLazySingleton<CustomersService>(
    () => CustomersImpl(),
  );
  getIt.registerLazySingleton<CustomersRepo>(
    () => CustomersRepo(
      customersService: getIt<CustomersService>(),
      imagePickerService: getIt<ImagePickerService>(),
    ),
  );
  getIt.registerFactory<CustomersBloc>(
    () => CustomersBloc(getIt<CustomersRepo>()),
  );

  getIt.registerLazySingleton<ImagePickerService>(
    () => ImagePickImpl(),
  );

  getIt.registerFactory<ImagePickBloc>(
    () => ImagePickBloc(getIt<CustomersRepo>()),
  );

//Cart Instance
  getIt.registerLazySingleton<CartDBService>(
    () => CartDBImpl(),
  );
  getIt.registerLazySingleton<CartRepo>(
    () => CartRepo(
      cartDBService: getIt<CartDBService>(),
    ),
  );
  getIt.registerFactory<CartBloc>(
    () => CartBloc(getIt<CartRepo>()),
  );

  //Order Instance
  getIt.registerLazySingleton<OrderService>(
    () => OrderImpl(),
  );
  getIt.registerLazySingleton<OrderRepo>(
    () => OrderRepo(
      orderService: getIt<OrderService>(),
    ),
  );
  getIt.registerFactory<PlaceOrderBloc>(
    () => PlaceOrderBloc(getIt<OrderRepo>()),
  );
}
