import 'dart:developer';
import 'package:biller/src/constants/constants.dart';
import 'package:biller/src/logic/customers/customers_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class Customers extends StatelessWidget {
  Customers({super.key});
  final dragController = DraggableScrollableController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Customers',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              onChanged: (value) {
                log("----> $value");
              },
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
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CupertinoIcons.qrcode),
                    Hero(
                      tag: 'add-customer',
                      child: IconButton(
                        onPressed: () {
                          context.pushNamed('create-customer');
                        },
                        icon:
                            Icon(Icons.add_circle, color: Colors.blue.shade900),
                      ),
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<CustomersBloc, CustomersState>(
        builder: (context, state) {
          if (state is CustomersLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
          if (state is CustomersFailed) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          if (state is CustomersSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CustomersBloc>().add(FetchCustomersEvent());
              },
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        constraints: constraints,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: state.customers[index].imageBytes ==
                                          null
                                      ? null
                                      : DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(
                                            state.customers[index].imageBytes!,
                                          ),
                                        ),
                                ),
                              ),
                              const VerticalDivider(
                                indent: 16,
                                endIndent: 16,
                                width: 32,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.customers[index].name?.toUpperCase()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    setHeight(height: 4),
                                    Text(
                                      '${state.customers[index].street},${state.customers[index].streetTwo},${state.customers[index].city},${state.customers[index].state}',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    // setHeight(height: 4),
                                    // RichText(
                                    //   text: const TextSpan(
                                    //     text: 'Due Amout : ',
                                    //     style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.black,
                                    //     ),
                                    //     children: [
                                    //       TextSpan(
                                    //         text: '\$570',
                                    //         style: TextStyle(
                                    //           color: Colors.red,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              setWidth(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final Uri launchUri = Uri(
                                            scheme: 'tel',
                                            path:
                                                '+91${state.customers[index].mobileNumber}',
                                          );
                                          await launchUrl(launchUri);
                                        },
                                        child: Icon(
                                          CupertinoIcons.phone_circle_fill,
                                          color: Colors.blue.shade900,
                                        ),
                                      ),
                                      setWidth(width: 8),
                                      GestureDetector(
                                        onTap: () async {
                                          final Uri launchUri = Uri.parse(
                                            'https://api.whatsapp.com/send?phone=91${state.customers[index].mobileNumber}',
                                          );
                                          await launchUrl(launchUri);
                                        },
                                        child: Image.asset(
                                          'assets/whatsapp.png',
                                          height: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.transparent,
                  );
                },
                itemCount: state.customers.length,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
