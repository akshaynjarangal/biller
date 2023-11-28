import 'package:biller/src/constants/routes.dart';
import 'package:biller/src/dependency_injection/di.dart';
import 'package:biller/src/dependency_injection/get_it.dart';
import 'package:biller/src/logic/bottom_nav/bottom_nav_bloc.dart';
import 'package:biller/src/logic/cart/cart_bloc.dart';
import 'package:biller/src/logic/home_grid/home_grid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  await Hive.initFlutter();
  getIt<DBRepository>().setupDBAdapter();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavBloc(),
        ),
        BlocProvider(
          create: (context) => HomeGridBloc(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductsBloc>()..add(FetchProductsEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<CustomersBloc>()..add(FetchCustomersEvent()),
        ),
         BlocProvider(
          create: (context) => getIt<CartBloc>()..add(FetchCart()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Biller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
