import 'dart:developer';
import 'package:biller/src/constants/constants.dart';
import 'package:biller/src/dependency_injection/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CreateCustomer extends StatelessWidget {
  CreateCustomer({super.key});

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final streetController = TextEditingController();
  final streetTwoController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final countryController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    log("Create Customer");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Customer",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Hero(
            tag: "add_customer",
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade100,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Customer Name",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                setHeight(height: 8),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter customer name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    hintText: 'Enter customer name',
                  ),
                ),
                setHeight(height: 16),
                const Text(
                  "Mobile Number",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                TextFormField(
                  controller: mobileController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 10) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    hintText: 'Enter mobile number',
                  ),
                ),
                setHeight(height: 16),
                const Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    hintText: 'Enter email',
                  ),
                ),
                setHeight(height: 32),
                const Text(
                  "Upload Image",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                setHeight(height: 8),
                BlocBuilder<ImagePickBloc, ImagePickState>(
                  builder: (context, state) {
                    if (state.file != null) {
                      return Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  context.watch<ImagePickBloc>().state.file!,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              border: Border.all(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await selectImage(
                              context,
                            ).then((value) {
                              if (value != null) {
                                context.read<ImagePickBloc>().add(
                                      ChooseImageEvent(
                                        source: value,
                                      ),
                                    );
                              }
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              border: Border.all(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.arrowUpFromBracket,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                setHeight(height: 32),
                const Text(
                  "Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                setHeight(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: streetController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter street name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          hintText: 'Street Name',
                        ),
                      ),
                    ),
                    setWidth(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: streetTwoController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter street name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          hintText: 'Street Name 2',
                        ),
                      ),
                    ),
                  ],
                ),
                setHeight(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cityController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          hintText: 'City',
                        ),
                      ),
                    ),
                    setWidth(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: pincodeController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 6) {
                            return 'Please enter pin code';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                            6,
                          ),
                        ],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          hintText: 'Pincode',
                        ),
                      ),
                    ),
                  ],
                ),
                setHeight(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select country';
                          }
                          return null;
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Country',
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                        ),
                        items: countryList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          countryController.text = value.toString();
                        },
                      ),
                    ),
                    setWidth(width: 8),
                    Expanded(
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select state';
                          }
                          return null;
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        menuMaxHeight: 200,
                        decoration: InputDecoration(
                          hintText: 'State',
                          border: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                        ),
                        items: indiaStates.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          stateController.text = value.toString();
                        },
                      ),
                    ),
                  ],
                ),
                setHeight(height: 32),
                BlocConsumer<CustomersBloc, CustomersState>(
                  listener: (context, state) {
                    if (state is CustomersFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "Something went wrong",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is CustomersSuccess) {
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    if (state is CustomersLoading && state.isCreating) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900,
                          strokeWidth: 2,
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.blue.shade900,
                              ),
                            ),
                            onPressed: () {
                              if (context.read<ImagePickBloc>().state.file ==
                                  null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Please select image",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (formKey.currentState!.validate() &&
                                  context.read<ImagePickBloc>().state.file !=
                                      null) {
                                final Map<String, String> customer = {
                                  "name": nameController.text,
                                  "mobile_number": mobileController.text,
                                  "email": emailController.text,
                                  "street": streetController.text,
                                  "street_two": streetTwoController.text,
                                  "city": cityController.text,
                                  "pincode": pincodeController.text,
                                  "country": countryController.text,
                                  "state": stateController.text,
                                };
                                context.read<CustomersBloc>().add(
                                      CreateCustomerEvent(
                                        customer: customer,
                                        path: context
                                            .read<ImagePickBloc>()
                                            .state
                                            .file!,
                                      ),
                                    );
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
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
        ),
      ),
    );
  }
}
