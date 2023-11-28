import 'package:biller/src/constants/constants.dart';
import 'package:biller/src/logic/cart/cart_bloc.dart';
import 'package:biller/src/logic/place_order/place_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
    required this.customerId,
    required this.customerName,
  });
  final String customerId;
  final String customerName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Your Cart',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            setHeight(height: 8),
            Text(
              customerName.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
            ),
          ],
        ),
      ),
      body: customerName.isEmpty
          ? Center(
              child: Text(
                'Select a customer to add products',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
          : BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state.cartProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/cart.json',
                          height: 200,
                          width: 200,
                        ),
                        setHeight(height: 16),
                        Text(
                          'Your cart is empty',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        // setHeight(height: 16),
                        // ElevatedButton(
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStatePropertyAll(appPrimaryColor),
                        //   ),
                        //   onPressed: () {
                        //     context.read<BottomNavBloc>().add(const ChangeIndex(index: 0));
                        //   },
                        //   child: const Text(
                        //     'Continue',
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.only(left: 16),
                            title: Text(
                              "${state.cartProducts[index].name?.toUpperCase()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              '\u{20B9} ${state.cartProducts[index].price}',
                            ),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: appPrimaryColor,
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context.read<CartBloc>().add(
                                                UpdateCart(
                                                  key: state
                                                      .cartProducts[index].id!,
                                                  isIncrement: false,
                                                ),
                                              );
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                      setWidth(width: 8),
                                      Text(
                                        '${state.cartProducts[index].quantity}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                      ),
                                      setWidth(width: 8),
                                      GestureDetector(
                                        onTap: () {
                                          context.read<CartBloc>().add(
                                                UpdateCart(
                                                  key: state
                                                      .cartProducts[index].id!,
                                                  isIncrement: true,
                                                ),
                                              );
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                          RemoverFromCart(
                                            key: state.cartProducts[index].id!,
                                          ),
                                        );
                                  },
                                  icon: const Icon(
                                    IconlyLight.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.transparent,
                          );
                        },
                        itemCount: state.cartProducts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      setHeight(height: 16),
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal'),
                                Text('₹ ${(state.cartTotal-state.cartTotal*0.05).toStringAsFixed(2)}'),
                              ],
                            ),
                            const Divider(
                              height: 18,
                              color: Colors.transparent,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Tax (5%)'),
                                Text('₹ ${(state.cartTotal*0.05).toStringAsFixed(2)}'),
                              ],
                            ),
                            const Divider(
                              height: 36,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₹ ${state.cartTotal}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            setHeight(height: 32),
                            BlocConsumer<PlaceOrderBloc, PlaceOrderState>(
                              listener: (context, state) {
                                if (state is PlaceOrderFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        state.message,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (state is PlaceOrderSuccess) {
                                  context.goNamed('success');
                                  context.read<CartBloc>().add(ClearCart());
                                }
                              },
                              builder: (context, state) {
                                if (state is PlaceOrderLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: appPrimaryColor,
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          appPrimaryColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        final order = {
                                          'customer_id': customerId,
                                          "total_price": context
                                              .read<CartBloc>()
                                              .state
                                              .cartTotal,
                                          'products': context
                                              .read<CartBloc>()
                                              .state
                                              .cartProducts
                                              .map(
                                                (e) => {
                                                  'product_id': e.productId,
                                                  'quantity': e.quantity,
                                                  'price': e.price,
                                                },
                                              )
                                              .toList(),
                                        };

                                        context
                                            .read<PlaceOrderBloc>()
                                            .add(PlaceOrder(order: order));
                                      },
                                      child: const Text(
                                        'Order',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          appPrimaryColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        final order = {
                                          'customer_id': customerId,
                                          "total_price": context
                                              .read<CartBloc>()
                                              .state
                                              .cartTotal,
                                          'products': context
                                              .read<CartBloc>()
                                              .state
                                              .cartProducts
                                              .map(
                                                (e) => {
                                                  'product_id': e.productId,
                                                  'quantity': e.quantity,
                                                  'price': e.price,
                                                },
                                              )
                                              .toList(),
                                        };

                                        context
                                            .read<PlaceOrderBloc>()
                                            .add(PlaceOrder(order: order));
                                      },
                                      child: const Text(
                                        'Order & Deliver',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
