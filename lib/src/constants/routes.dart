import 'package:biller/src/dependency_injection/di.dart';
import 'package:biller/src/dependency_injection/get_it.dart';
import 'package:biller/src/screens/bottom_nav.dart';
import 'package:biller/src/screens/cart.dart';
import 'package:biller/src/logic/place_order/place_order_bloc.dart';
import 'package:biller/src/screens/create_customer.dart';
import 'package:biller/src/screens/order_placed_screen.dart';
import 'package:biller/src/screens/products/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final navKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: navKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const BottomNav();
      },
      routes: [
        GoRoute(
          pageBuilder: (context, state) => bottomToTopTransition(
            state,
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:(context)=> getIt<ImagePickBloc>(),
                ),
              ],
              child:  CreateCustomer(),
            ),
          ),
          name: 'create-customer',
          path: 'create-customer',
        ),
        GoRoute(
          pageBuilder: (context, state) => bottomToTopTransition(
            state,
            Products(
              customerId: state.uri.queryParameters['customer_id'] ?? "",
              customerName: state.uri.queryParameters['customer_name'] ?? "",
            ),
          ),
          name: 'products',
          path: 'products',
          routes: [
            GoRoute(
              pageBuilder: (context, state) => bottomToTopTransition(
                state,
                BlocProvider(
                  create: (context) => getIt<PlaceOrderBloc>(),
                  child: Cart(
                    customerId: state.uri.queryParameters['customer_id'] ?? "",
                    customerName:
                        state.uri.queryParameters['customer_name'] ?? "",
                  ),
                ),
              ),
              name: 'cart',
              path: 'cart',
              routes: [
                GoRoute(
                  pageBuilder: (context, state) => bottomToTopTransition(
                    state,
                    const OrderPlacedSuccess(),
                  ),
                  name: 'success',
                  path: 'success',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

CustomTransitionPage<dynamic> bottomToTopTransition(
  GoRouterState state,
  Widget page,
) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
