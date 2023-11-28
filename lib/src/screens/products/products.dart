import 'dart:developer';

import 'package:biller/src/constants/constants.dart';
import 'package:biller/src/data/models/cart_product_model.dart';
import 'package:biller/src/logic/cart/cart_bloc.dart';
import 'package:biller/src/logic/products/products_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Products extends StatelessWidget {
  const Products({
    super.key,
    required this.customerId,
    required this.customerName,
  });
  final String customerId;
  final String customerName;
  @override
  Widget build(BuildContext context) {
    log("------------->    $customerName -----> ${customerName.runtimeType} ");
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Products',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            setHeight(height: 8),
            Text(
              customerName.isEmpty
                  ? 'Select a customer'
                  : customerName.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.search),
                  ],
                ),
                suffixIcon: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(CupertinoIcons.qrcode),
                      const VerticalDivider(
                        indent: 8,
                        endIndent: 8,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              CupertinoIcons.chevron_down,
                              size: 14,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(child: Text('Fruits')),
                          ],
                          onChanged: (val) {},
                        ),
                      ),
                    ],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: customerName.isEmpty
          ? null
          : BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state.cartProducts.isEmpty) {
                  return const Column(
                    mainAxisSize: MainAxisSize.min,
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(appPrimaryColor),
                        ),
                        onPressed: () {
                          context.pushNamed(
                            'cart',
                            queryParameters: {
                              'customer_id': customerId,
                              'customer_name': customerName,
                            },
                          );
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue.shade900,
              ),
            );
          }
          if (state is ProductsFailed) {
            return const Center(
              child: Text('Something went wrong..!'),
            );
          }
          if (state is ProductsSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductsBloc>().add(FetchProductsEvent());
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Image.memory(
                                state.products[index].imageBytes!,
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${state.products[index].name?.toUpperCase()}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '\u{20B9}${state.products[index].price}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(
                                    indent: 8,
                                    endIndent: 8,
                                  ),
                                  BlocBuilder<CartBloc, CartState>(
                                    builder: (context, cartstate) {
                                      final cart = cartstate.cartProducts
                                          .where(
                                            (element) =>
                                                element.productId ==
                                                state.products[index].id,
                                          )
                                          .toList();

                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.blue.shade900,
                                        ),
                                        child: customerName.isNotEmpty &&
                                                cart.isNotEmpty
                                            ? Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                            UpdateCart(
                                                              key:
                                                                  cart[0].id!,
                                                              isIncrement:
                                                                  false,
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
                                                    '${cart[0].quantity}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                  setWidth(width: 8),
                                                  GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                            UpdateCart(
                                                              key:
                                                                  cart[0].id!,
                                                              isIncrement:
                                                                  true,
                                                            ),
                                                          );
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : GestureDetector(
                                              onTap: (){
                                                if (customerName.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                              ..hideCurrentSnackBar()
                                              ..showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    'Go to New Order & select a customer',
                                                  ),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                          } else {
                                            context.read<CartBloc>().add(
                                                  AddToCart(
                                                    cartProductModel:
                                                        CartProductModel(
                                                      productId: state
                                                          .products[index].id,
                                                      price: state
                                                          .products[index]
                                                          .price,
                                                      quantity: 1,
                                                      name: state
                                                          .products[index].name,
                                                    ),
                                                  ),
                                                );
                                          }
                                              },
                                              child: const Text(
                                                  'Add',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                            ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
