import 'dart:io';

import 'package:biller/src/data/models/customers_list_model.dart';

abstract class CustomersService {

  Future<List<CustomersListModel>> getCustomers();
  
  //create customer
  Future<bool> createCustomer({required Map<String, String> customer, required File path});
  
}