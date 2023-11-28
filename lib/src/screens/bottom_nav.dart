import 'package:biller/src/screens/cart.dart';
import 'package:biller/src/screens/customers.dart';
import 'package:biller/src/screens/home.dart';
import 'package:biller/src/screens/new_order.dart';
import 'package:biller/src/screens/return_order.dart';
import 'package:biller/src/logic/bottom_nav/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.index,
            children: [
              const Home(),
              const NewOrder(),
              const Cart(customerId: '',customerName: '',),
              const ReturnOrder(),
              Customers(),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return BottomNavigationBar(
            elevation: 50,
            selectedFontSize: 12,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: const Color.fromARGB(255, 23, 77, 171),
            selectedItemColor: const Color.fromARGB(255, 23, 77, 171),
            currentIndex: state.index,
            onTap: (value) =>
                context.read<BottomNavBloc>().add(ChangeIndex(index: value)),
            items: [
              const BottomNavigationBarItem(
                activeIcon: Icon(IconlyBold.home),
                icon: Icon(IconlyLight.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                activeIcon: Icon(IconlyBold.plus),
                icon: Icon(IconlyLight.plus),
                label: 'New Order',
              ),
              const BottomNavigationBarItem(
                activeIcon: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(IconlyBold.buy),
                    // if (context.read<CartBloc>().state.cartProducts.isNotEmpty)
                    //   Container(
                    //     height: 14,
                    //     width: 14,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.white),
                    //       color: appPrimaryColor,
                    //       borderRadius: BorderRadius.circular(7),
                    //     ),
                    //     child:
                    //         context.read<CartBloc>().state.cartProducts.length >
                    //                 9
                    //             ? const Text(
                    //                 '9+',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 8,
                    //                 ),
                    //               )
                    //             : FittedBox(
                    //                 child: Text(
                    //                   '${context.watch<CartBloc>().state.cartProducts.length}',
                    //                   style: const TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 8,
                    //                   ),
                    //                 ),
                    //               ),
                    //   ),
                  ],
                ),
                icon: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(IconlyLight.buy),
                    // if (context.read<CartBloc>().state.cartProducts.isNotEmpty)
                    //   Container(
                    //     height: 14,
                    //     width: 14,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.white),
                    //       color: appPrimaryColor,
                    //       borderRadius: BorderRadius.circular(7),
                    //     ),
                    //     child:
                    //         context.read<CartBloc>().state.cartProducts.length >
                    //                 9
                    //             ? const Text(
                    //                 '9+',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 8,
                    //                 ),
                    //               )
                    //             : FittedBox(
                    //                 child: Text(
                    //                   '${context.watch<CartBloc>().state.cartProducts.length}',
                    //                   style: const TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 8,
                    //                   ),
                    //                 ),
                    //               ),
                    //   ),
                  ],
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                activeIcon: Transform.flip(
                  flipX: true,
                  child: const Icon(IconlyBold.logout),
                ),
                icon: Transform.flip(
                  flipX: true,
                  child: const Icon(IconlyLight.logout),
                ),
                label: 'Return',
              ),
              const BottomNavigationBarItem(
                activeIcon: Icon(IconlyBold.user_3),
                icon: Icon(IconlyLight.user_1),
                label: 'Customers',
              ),
            ],
          );
        },
      ),
    );
  }
}
